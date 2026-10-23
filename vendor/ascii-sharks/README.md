# ascii-sharks (vendored, modified)

Source: https://github.com/stackedlol/ascii-sharks (commit c521e24). No license yet — ask the author before publishing.

Local changes, so one canvas can cover the whole page:
- `World`/`OceanEngine` take a `focus` zone (the hero headline): sharks start around it and steer clear of it.
- Patrol ellipse stretches to tall canvases; fish cap raised to 900.
- Sharks beyond the first four start spread down the canvas instead of around the focus zone.
- `mono` option: sharks and fish drawn in one flat white on black (no shading, accents, wake or bite flashes), so the page can invert it cleanly.
- `tint` option: one colour for every shark instead of per-species tints (some are warm/beige), and no random accent-coloured glyphs.
- `sharkSeparation` option ({ strength, range }): sharks steer off each other's bodies instead of overlapping (modelled on catchWhat's separation force).
- `obstacles` / `obstacleAvoidance` options: sharks steer around rectangles (the page's images) and don't chase fish hidden behind them.
- Canvas created with `alpha: true` so glyphs get greyscale anti-aliasing (no orange/blue LCD fringes).
- Device-pixel ratio is capped to stay under iOS Safari's canvas size limit.

Rebuild `js/ascii-sharks.js` from the repo root:

    npx esbuild vendor/ascii-sharks/src/index.ts --bundle --format=esm --minify --target=es2020 --outfile=js/ascii-sharks.js
