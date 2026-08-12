This is a fork of [ejgallego/verso-carleson](https://github.com/ejgallego/verso-carleson)
which drops the dependency on the Carleson formalization [fpvandoorn/carleson](https://github.com/fpvandoorn/carleson),
instead placing pseudorandomly selected theorems from mathlib in the same blueprint graph.
Used as a real-world example for benchmarking Verso and Verso Blueprint builds.

## Adapting to new toolchains

`scripts/pre-build.sh` selects a pre-committed list of theorems
from the latest mathlib tag equal to or below the current lean-toolchain.
This list is somewhat stable across mathlib releases
(we select N theorems with minimal hash),
but it stops working when a listed theorem is removed from mathlib.
A new list should be added in this case by running

```shell
TOOLCHAIN=$(cat lean-toolchain)
lake lean scripts/PrintConstants.lean > constant-lists/$TOOLCHAIN.txt
```
