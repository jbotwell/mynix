#!/bin/bash
ctags() {
  set -e
  PATH="/usr/local/bin:$PATH"
  trap 'rm -f "$$.tags"' EXIT
  git ls-files | ctags --tag-relative -L - -f"$$.tags"
  mv "$$.tags" "tags"
}

ctags >/dev/null 2>&1 &

case "$1" in
  rebase) exec .git/hooks/post-merge ;;
esac
