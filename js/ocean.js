// ASCII sharks behind the page. Load /ocean.css too.
//
//   startOcean({ hero: "#hero", obstacles: ".about-photo, .gallery" });
//
// hero: the ocean is dark inside this element and light below it; leave it out
//   and the whole page is light. Sharks start circling it and keep off it.
// obstacles: elements the sharks swim around (photos, cards, text blocks).
// sharkSize: scales every shark (e.g. 0.6 on a dense page so they fit the gaps).
// avoidance: how hard sharks turn away from obstacles; 0 turns it off.
import { OceanEngine } from "/js/ascii-sharks.js";

// The first four start around the hero (or the middle of the page); the rest
// start further down so the lower page isn't empty.
const SHARKS = [
  { kind: "classic", size: 1 },
  { kind: "classic", size: 0.7 },
  { kind: "classic", size: 0.84 },
  { kind: "classic", size: 0.77 },
  { kind: "hammerhead", size: 0.9 },
  { kind: "tiger", size: 0.8 },
  { kind: "mako", size: 0.75 },
  { kind: "thresher", size: 0.85 },
];

export function startOcean({ hero = null, obstacles = "", sharkSize = 1, avoidance = 8 } = {}) {
  const canvas = document.createElement("canvas");
  canvas.id = "ocean";
  const wash = ["ocean-wash", "ocean-ink"].map((id) => {
    const el = document.createElement("div");
    el.id = id;
    return el;
  });
  for (const el of [canvas, ...wash]) el.setAttribute("aria-hidden", "true");
  document.body.prepend(canvas, ...wash);

  const heroEl = hero ? document.querySelector(hero) : null;
  const obstacleEls = obstacles ? [...document.querySelectorAll(obstacles)] : [];

  // Element box in page coordinates (the canvas starts at the top of <body>).
  function pageBox(el) {
    const r = el.getBoundingClientRect();
    const b = document.body.getBoundingClientRect();
    return { x: r.left - b.left, y: r.top - b.top, w: r.width, h: r.height };
  }

  let obstacleBoxes = [];
  function layout() {
    const h = heroEl ? pageBox(heroEl) : null;
    for (const el of wash) el.style.top = `${h ? h.y + h.h : 0}px`;
    obstacleBoxes = obstacleEls.map(pageBox);
  }
  layout();
  new ResizeObserver(layout).observe(document.body);

  const sharks = SHARKS.map((s) => ({ ...s, size: s.size * sharkSize }));
  return new OceanEngine(canvas, sharks, {
    mono: false,   // true: one flat colour per side instead of shaded sharks
    tint: [1, 1, 1],   // every shark one neutral white (no beige species tints)
    // Avoid colliding: how hard sharks steer off each other (0 = off), and from how far
    // away, as a fraction of the two sharks' combined length.
    sharkSeparation: { strength: 10, range: 0.7 },
    obstacles: () => obstacleBoxes,
    obstacleAvoidance: avoidance,
    focus: heroEl
      ? () => {
          const { x, y, w, h } = pageBox(heroEl);
          return { x: x + w / 2, y: y + h / 2, rx: Math.min(w * 0.3, 360), ry: h * 0.22 };
        }
      : undefined,
  });
}
