---
id: quote-retrieval-planning-linear-draft
aliases: []
tags:
  - #planning
  - #cycle/july
  - #draft-issue
parent: "[[quote-retrieval]]"
---
# Employee Portal Quote Retrieval — Linear issue draft

- _[Linear project](https://linear.app/electriccarscheme/project/employee-portal-quote-retrieval-3451670a635e/overview)_
- Plan: [[quote-retrieval-claude-plan]]

Draft issues in my own style (User Stories / Tech Considerations / Acceptance Criteria,
time-based sizing). **Not yet created in Linear** — review first.

Built for the new Lead-based flow. Depends on the Lead model + question flow
([[product-selection-qualification-claude-plan]]: NZB-103/104) and Leighton's comparison page.

**Order = priority:** 1 (High) → 2, 3, 4 (Medium). Total ≈ 2 weeks.

Decided: **in-progress quotes never expire** — dropped the old abandoned/expiry issue.

Decide before creating in Linear:
- Remaining product open questions (re-run vs original pricing, login vs magic link, read-only
  vs re-runnable) — re-run vs original still gates #1.
- Priority mapping (below) + labels or not (last project: no labels).

---

## 1. Resume / finish an in-progress quote · `label: 0.5 weeks` · _Priority: High_ · [NZB-106](https://linear.app/electriccarscheme/issue/NZB-106/resume-finish-an-in-progress-quote)

**User Stories**
- As an employee, I can pick up an in-progress quote where I left off, with previous answers intact, so I don't restart from the beginning.

**Tech Considerations**
- The old solar `Show.tsx` already does "open with no `?step=` → first incomplete step" — same
  pattern to port.

**Acceptance Criteria**
- [ ] Resuming lands at the correct step with prior answers intact
- [ ] Admin reflects real-time progress once resumed

## 2. View a completed quote (read-only) · `label: 0.5 weeks` · _Priority: Medium_ · [NZB-107](https://linear.app/electriccarscheme/issue/NZB-107/view-a-completed-quote-read-only)

**User Stories**
- As an employee, I can open a completed quote and see the same comparison output as when I finished it, so I can return at any time and book a call.

**Acceptance Criteria**
- [ ] Employee can open a completed quote read-only
- [ ] Output matches what they saw at completion

## 3. "My quotes" list page · `label: 1 week` · _Priority: Medium_ · [NZB-108](https://linear.app/electriccarscheme/issue/NZB-108/my-quotes-list-page)

**User Stories**
- As an employee, I can see a list of my in-progress and completed quotes in the portal.

**Tech Considerations**
- No list page exists today — home pages are marketing-only.

**Acceptance Criteria**
- [ ] Employee sees their started and completed quotes
- [ ] In-progress and completed are distinguishable

## 4. Surface NZH quotes on the dashboard · `label: 1 day` · _Priority: Low_ · [NZB-109](https://linear.app/electriccarscheme/issue/NZB-109/surface-nzh-quotes-on-the-dashboard)

**User Stories**
- As an employee, I can see my Net Zero Home quotes from the main portal dashboard.

**Tech Considerations**
- `pages/Dashboard.tsx` currently lists car/charge/reimburse orders — no NZH section.

**Acceptance Criteria**
- [ ] Dashboard shows the employee's NZH quotes
- [ ] Links through to resume / view
