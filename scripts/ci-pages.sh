#!/usr/bin/env bash

set -euo pipefail

python3 tools/verso-harness/scripts/ensure_dependency_cache.py --project-root . --warm-cache
lake build +BlueprintMain 2>&1 | python3 scripts/filter_docstring_warnings.py --project-root .
python3 tools/verso-harness/scripts/ensure_dependency_cache.py --project-root .
lake env lean --run BlueprintMain.lean --output _out/site 2>&1 | python3 scripts/filter_docstring_warnings.py --project-root .
python3 tools/verso-harness/scripts/check_generated_site.py --project-root . --site-dir _out/site/html-multi
