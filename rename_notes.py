#!/usr/bin/env python3
"""
Rename opaque obsidian notes (e.g. 1772445500-QANZ.md) to title-based slugs,
then update all wikilinks across the vault.

Usage:
  python3 rename_notes.py          # dry run — prints plan, makes no changes
  python3 rename_notes.py --apply  # apply changes
"""

import os
import re
import sys
import glob

NOTES_DIR = "/Users/peyton.sterling/notes"
SUBDIRS = ["in-use", "inbox", "permanent_notes"]
ALL_MD_DIRS = ["in-use", "inbox", "permanent_notes", "daily-notes"]

OPAQUE_ID = re.compile(r"^\d+-[A-Z]{4}$")
DRY_RUN = "--apply" not in sys.argv


def slugify(title: str) -> str:
    s = title.replace("`", "")
    s = s.lower()
    s = s.replace(" ", "-")
    s = re.sub(r"[^a-z0-9-]", "", s)
    s = re.sub(r"-+", "-", s)
    return s.strip("-")


def parse_aliases(content: str) -> list[str]:
    """Extract alias values from YAML frontmatter."""
    fm_match = re.match(r"^---\n(.*?)\n---", content, re.DOTALL)
    if not fm_match:
        return []
    fm = fm_match.group(1)
    in_aliases = False
    aliases = []
    for line in fm.splitlines():
        if re.match(r"^aliases:", line):
            in_aliases = True
            continue
        if in_aliases:
            m = re.match(r"^\s+-\s+(.+)", line)
            if m:
                aliases.append(m.group(1).strip())
            elif not line.startswith(" "):
                break
    return aliases


# ── Step 1: build old_id → new_slug mapping ──────────────────────────────────

id_to_slug: dict[str, str] = {}   # opaque file stem  → slug
ref_to_slug: dict[str, str] = {}  # any wikilink ref (incl. aliases) → slug
used_slugs: set[str] = set()

for subdir in SUBDIRS:
    for filepath in sorted(glob.glob(os.path.join(NOTES_DIR, subdir, "*.md"))):
        stem = os.path.splitext(os.path.basename(filepath))[0]
        if not OPAQUE_ID.match(stem):
            continue

        with open(filepath) as f:
            content = f.read()

        title_m = re.search(r"^# (.+)$", content, re.MULTILINE)
        if not title_m:
            print(f"WARNING: no # title in {filepath} — skipping")
            continue

        base = slugify(title_m.group(1).strip())
        slug = base
        counter = 2
        while slug in used_slugs:
            slug = f"{base}-{counter}"
            counter += 1
        used_slugs.add(slug)

        id_to_slug[stem] = slug
        ref_to_slug[stem] = slug

        # Also register opaque aliases so links via alias resolve correctly
        for alias in parse_aliases(content):
            if OPAQUE_ID.match(alias):
                ref_to_slug[alias] = slug

# ── Step 2: print plan ───────────────────────────────────────────────────────

print("=== Rename plan ===")
for subdir in SUBDIRS:
    for filepath in sorted(glob.glob(os.path.join(NOTES_DIR, subdir, "*.md"))):
        stem = os.path.splitext(os.path.basename(filepath))[0]
        if stem in id_to_slug:
            new_name = id_to_slug[stem] + ".md"
            print(f"  {subdir}/{stem}.md  →  {subdir}/{new_name}")

print("\n=== Wikilink substitutions ===")
for old, new in sorted(ref_to_slug.items()):
    if old != new:
        print(f"  [[{old}...]]  →  [[{new}...]]")

if DRY_RUN:
    print("\n(dry run — pass --apply to make changes)")
    sys.exit(0)

# ── Step 3: update file contents first, then rename ──────────────────────────

def replace_wikilinks(content: str) -> str:
    """Replace [[old_ref]] and [[old_ref|display]] with [[new_slug|display]] or [[new_slug]]."""
    def replacer(m: re.Match) -> str:
        ref = m.group(1)
        display = m.group(2)  # may be None
        new_ref = ref_to_slug.get(ref, ref)
        if display is not None:
            return f"[[{new_ref}|{display}]]"
        else:
            return f"[[{new_ref}]]"

    return re.sub(r"\[\[([^\]|]+)(?:\|([^\]]*))?\]\]", replacer, content)


def update_frontmatter_id(content: str, old_id: str, new_slug: str) -> str:
    return re.sub(
        rf"^(id:\s*){re.escape(old_id)}$",
        rf"\g<1>{new_slug}",
        content,
        flags=re.MULTILINE,
    )


# Update wikilinks in ALL markdown files (including daily-notes)
for subdir in ALL_MD_DIRS:
    for filepath in glob.glob(os.path.join(NOTES_DIR, subdir, "*.md")):
        with open(filepath) as f:
            original = f.read()
        updated = replace_wikilinks(original)
        if updated != original:
            print(f"  updated links in {subdir}/{os.path.basename(filepath)}")
            with open(filepath, "w") as f:
                f.write(updated)

# Update frontmatter id: field and rename files
for subdir in SUBDIRS:
    for filepath in sorted(glob.glob(os.path.join(NOTES_DIR, subdir, "*.md"))):
        stem = os.path.splitext(os.path.basename(filepath))[0]
        if stem not in id_to_slug:
            continue
        new_slug = id_to_slug[stem]
        new_path = os.path.join(NOTES_DIR, subdir, new_slug + ".md")

        with open(filepath) as f:
            content = f.read()
        content = update_frontmatter_id(content, stem, new_slug)
        with open(filepath, "w") as f:
            f.write(content)

        os.rename(filepath, new_path)
        print(f"  renamed {subdir}/{stem}.md  →  {subdir}/{new_slug}.md")

print("\nDone.")
