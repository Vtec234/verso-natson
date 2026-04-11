# Carleson Blueprint

This repository is the completed Verso port and integration repo for `Carleson Blueprint`.

- Upstream formalization: [Carleson/](Carleson/)
- Shared harness: [tools/verso-harness/](tools/verso-harness/)
- Harness config: [verso-harness.toml](verso-harness.toml)
- Root blueprint module: [CarlesonBlueprint.lean](CarlesonBlueprint.lean)
- Main direct-port chapter: [CarlesonBlueprint/Chapters/Main.lean](CarlesonBlueprint/Chapters/Main.lean)

## Pages

- Public site: <https://ejgallego.github.io/verso-carleson/>
- Workflow: [.github/workflows/blueprint.yml](.github/workflows/blueprint.yml)
- Actions page: <https://github.com/ejgallego/verso-carleson/actions/workflows/blueprint.yml>
- Local build: [`bash ./scripts/ci-pages.sh`](scripts/ci-pages.sh)
- Local output: `_out/site/html-multi/index.html`

## Port Source

The written-mathematics source of truth remains the legacy TeX / leanblueprint
material identified by `tex_source_glob` in [verso-harness.toml](verso-harness.toml).

In this repo, the direct-port TeX source is:

- [Carleson/blueprint/src/chapter/main.tex](Carleson/blueprint/src/chapter/main.tex)

For normal blueprint and integration work in this repo, treat the upstream
formalization checkout at [Carleson/](Carleson/) as read-only unless you are explicitly
doing upstream or fork work there.

## Workflow

This repo is a consumer of the shared harness. For startup, retrofit, LT audit,
and maintenance rules, use the harness docs:

- [tools/verso-harness/README.md](tools/verso-harness/README.md)
- [tools/verso-harness/references/start-new-port.md](tools/verso-harness/references/start-new-port.md)
- [tools/verso-harness/references/retrofit.md](tools/verso-harness/references/retrofit.md)
- [AGENTS.md](AGENTS.md)

Typical local checks:

```bash
python3 tools/verso-harness/scripts/check_harness.py --project-root .
python3 tools/verso-harness/scripts/status_harness.py --project-root . --offline
python3 tools/verso-harness/scripts/lt_audit.py --project-root . --node-kinds --math-sanity --native-warnings CarlesonBlueprint/Chapters/Main.lean
bash ./scripts/ci-pages.sh
```

## Notes

- Root `lean-toolchain` follows the upstream formalization toolchain.
- [lakefile.lean](lakefile.lean) pins the matching `VersoBlueprint` ref for that toolchain.
- The port is currently consolidated into [CarlesonBlueprint/Chapters/Main.lean](CarlesonBlueprint/Chapters/Main.lean).
- Generic LT commands should be run via `tools/verso-harness/scripts/...`.
