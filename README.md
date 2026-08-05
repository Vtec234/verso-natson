# Carleson Blueprint

[![Blueprint Pages](https://github.com/ejgallego/verso-carleson/actions/workflows/blueprint.yml/badge.svg)](https://github.com/ejgallego/verso-carleson/actions/workflows/blueprint.yml)

Verso Blueprint port of the Carleson Blueprint. The upstream formalization is
carried locally as the [`Carleson`](Carleson/) submodule.

Blueprint: <https://ejgallego.github.io/verso-carleson/>
Upstream blueprint repository:
[fpvandoorn/carleson](https://github.com/fpvandoorn/carleson)

This repo follows the upstream blueprint strictly and translates its source
markup language to Verso with the help of AI. Credit for the original blueprint
and formalization belongs to the upstream project.

## Build the Blueprint site

```bash
bash ./scripts/ci-pages.sh
```

The harness command checks the dependency cache before running
`lake exe vbp build --output _out/site`.

This repository follows the shared
[`tools/verso-harness`](tools/verso-harness/) workflow. The root
[`lean-toolchain`](lean-toolchain) selects Lean v4.33.0-rc2 for the wrapper.
The formalization currently selects v4.33.0-rc1; the exact reviewed
compatibility exception is recorded as `harness.wrapper_toolchain_override` in
[`verso-harness.toml`](verso-harness.toml). [`lakefile.lean`](lakefile.lean)
pins `VersoBlueprint` to the matching v4.33 release branch.
