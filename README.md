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

## Build

```bash
lake build
```

## Generate

```bash
lake env lean --run BlueprintMain.lean --output _out/site
```

This repository follows the shared
[`tools/verso-harness`](tools/verso-harness/) workflow. The root
[`lean-toolchain`](lean-toolchain) matches the upstream formalization, and
[`lakefile.lean`](lakefile.lean) pins `VersoBlueprint` to the matching release
branch.
