# NetworkLayout Release Notes

## Unreleased
- `Spring`, `SFDP`, `Stress`, `Spectral`, `Shell` and `SquareGrid` are compatible with `juliac --trim=safe` (checked in CI by `trim-check/`). The random layouts need an explicit `rng` keyword there, since the default `DEFAULT_RNG[](seed)` constructs an RNG type only known at run time.
- Fixes a type instability in `Stress`, whose stress value was computed as an `Int` before being promoted.

## v0.4.11 Changelog
- New `Egocentric` layout: stress majorization centered on a focal vertex, placing every node on a ring at its graph distance from the focus (Brandes & Pich 2011).
- Fixes two bugs in the iteration scheme:
  - The layout iterator returned the second-to-last layout; now it returns the final positions after full iteration.
  - Iterative layouts computed `iterations` layouts, including the initial guess. Now `iterations` describes the number of actual *iterations*, and the layout iterator returns at most `iterations + 1` layouts.
