#!/usr/bin/env bash
# Build static blog (3‑column grid + hero banner)            ← only tweaks:
#   • keep the existing header intact                         – titlebar ""
#   • append a Back‑to‑Blog link above the footer             – extra <nav>
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SITE_ROOT="$(realpath "$SCRIPT_DIR/..")"
POST_SRC="$SCRIPT_DIR/posts"
HEADER="$SCRIPT_DIR/header.html"
FOOTER="$SCRIPT_DIR/footer.html"
OUT_DIR="$SITE_ROOT"          # html output lives in /blog/

mkdir -p "$OUT_DIR"
TMP_INDEX="$(mktemp)"

# remove old post pages (keep index)
find "$OUT_DIR" -maxdepth 1 -type f -name '*.html' ! -name 'index.html' -delete

# helper: inject {{TITLEBAR}} & {{TITLE}} into header
write_header () {              # $1 = titlebar html, $2 = page title
  sed -e "s|{{TITLEBAR}}|$1|g" -e "s|{{TITLE}}|$2|g" "$HEADER"
}

# -----------------------------------------------------------------
# 1.  build each markdown → single‑post HTML
# -----------------------------------------------------------------
for md in "$POST_SRC"/*.md; do
  [[ -e "$md" ]] || continue
  slug="$(basename "${md%.*}")"
  dest="$OUT_DIR/$slug.html"

  title=$(grep -m1 '^title:' "$md" | cut -d':' -f2- | xargs)
  date=$(grep -m1 '^date:'  "$md" | awk '{print $2}')
  cover=$(grep -m1 '^cover:' "$md" | sed 's/^cover:[[:space:]]*//' | cut -d'#' -f1 | xargs)

  # front‑matter excerpt or first 3 lines
  excerpt=$(awk '/^excerpt:/ {flag=1;next} /^---/ {flag=0} flag' "$md" | head -n3)
  [[ $excerpt ]] || excerpt=$(grep -v '^---' "$md" | head -n3)

  body="$(pandoc --from=gfm --to=html5 "$md")"

  titlebar=''   # ← leave header unchanged

  { write_header "$titlebar" "$title"

    [[ -n $cover ]] && printf '<div class="hero" style="background-image:url(%q);"></div>\n' "$cover"

    printf '<article>%s</article>\n' "$body"

    # ----- Back‑to‑Blog link --------------------------------------
    cat <<'HTML'
<nav class="back-to-blog-wrapper">
  <a class="back-to-blog" href="/blog/">&larr; Back&nbsp;to&nbsp;Blog</a>
</nav>
HTML

    cat "$FOOTER"
  } > "$dest"

  # save metadata for index page
  clean_excerpt=$(echo "$excerpt" | tr '\n' ' ' | tr -s ' ' | cut -c1-140)
  printf '%s|%s|%s|%s|%s\n' "$slug" "$title" "$date" "$cover" "$clean_excerpt" >> "$TMP_INDEX"
done

# -----------------------------------------------------------------
# 2.  build the blog index page
# -----------------------------------------------------------------
sitebar='jxins – Ruixin'"'"'s Blog'

{
  write_header "$sitebar" "Blog"
  echo '<style>.back-to-blog-wrapper{display:none}</style>'

  echo '<section class="post-grid">'
  sort -r "$TMP_INDEX" | while IFS='|' read -r slug ttl dte cov exc; do
    echo "  <a class=\"post-card\" href=\"/blog/$slug.html\">"
    if [[ -n $cov ]]; then
      echo "    <figure><img loading=\"lazy\" src=\"$cov\" alt=\"\"></figure>"
    else
      echo '    <figure></figure>'
    fi
    echo '    <div class="post-content">'
    echo "      <h3>$ttl</h3>"
    echo "      <div class=\"post-meta\">$dte</div>"
    echo "      <p class=\"post-excerpt\">$exc</p>"
    echo '    </div>'
    echo '  </a>'
  done

  echo '</section>'
  cat "$FOOTER"
} > "$OUT_DIR/index.html"

rm "$TMP_INDEX"
echo "✅ Blog rebuilt at $(date)"
