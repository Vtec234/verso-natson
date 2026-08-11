#!/usr/bin/env bash

set -exuo pipefail

lake exe vbp build --output _out/site 2>&1 | python3 scripts/filter_docstring_warnings.py --project-root .
