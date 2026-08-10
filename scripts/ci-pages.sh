#!/usr/bin/env bash

set -euo pipefail

step() {
  printf '\n[ci-pages] %s\n' "$*" >&2
}

if [ -x scripts/ci-pre-build.sh ]; then
  step "running pre-build hook"
  scripts/ci-pre-build.sh
fi

step "building Blueprint site"
lake exe vbp build --output _out/site 2>&1 | python3 scripts/filter_docstring_warnings.py --project-root .
