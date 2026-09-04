# AGENT.md

Notes for agents (and humans) working in this repo.

## index.html stays a single, self-contained file on purpose

`wheel.png` and `wheel_frame.png` are inlined into `index.html` as base64
`data:` URIs. This is intentional: the page must be runnable as a single
file (e.g. opened locally, no server, no sibling assets required). Do not
"clean this up" by switching the `<img>` tags back to `src="wheel.png"` /
`src="wheel_frame.png"`.

`wheel.png` and `wheel_frame.png` are still kept as separate tracked files
because:
- `calibration.html` (a dev tool) loads them by relative path.
- `build.sh` reads them as the source of truth to re-embed into `index.html`.

If you replace either PNG, run `./build.sh` afterward to re-embed the new
image data into `index.html`. It rewrites `index.html` in place and is
idempotent (running it again with unchanged PNGs produces byte-identical
output).

## Other constraints

- `WIN_ANGLE_MIN` / `WIN_ANGLE_MAX` (351.8 / 6.0) define the winning range
  and wrap through 0. `isWinningAngle`'s wrap-around branch is deliberate,
  don't simplify it into a plain `min <= angle <= max` check.
- `ORIGIN_X` / `ORIGIN_Y` and the `transform-origin: 49.5% 52.8%` CSS are
  calibrated to the artwork. Leave them alone unless the artwork changes,
  and re-derive them with `calibration.html` if it does.
