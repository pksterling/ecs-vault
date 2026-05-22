---
id: remove-gem-directories-in-dockerfile-snippet
aliases: []
tags:
  - #snippet
---
# remove-gem-directories-in-dockerfile-snippet

## Why?
- Vulnerability is flagging unused versions of gems (as they are included in the
  Ruby image)
- This deletes the directories

```ruby
# Dockerfile

# Ruby #{CURRENT_VERSION} ships #{FLAGGED_GEM} #.#.# as a default gem with this
# version flagged by our vulnerability scanner. This removes it so the scanner
# sees only the newer version from the subsequent `bundle install`.
# TODO: Remove once Ruby ships with #{FLAGGED_GEM} >= #.#.#
RUN RUBY_GEM_DIR=$(ruby -e 'print Gem.default_dir') && \
    rm -rf "$RUBY_GEM_DIR"/gems/<FLAGGED_GEM>-* \
           "$RUBY_GEM_DIR"/specifications/default/<FLAGGED_GEM>-*.gemspec
```
