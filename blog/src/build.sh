#!/usr/bin/env bash
set -euo pipefail
shopt -s nullglob              # skip loop if no posts

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SITE_ROOT="$(realpath "$SCRIPT_DIR/..")"
POST_SRC="$SCRIPT_DIR/posts"
HEADER="$SCRIPT_DIR/header.html"
FOOTER="$SCRIPT_DIR/footer.html"
OUT_DIR="$SITE_ROOT"

mkdir -p "$OUT_DIR"

TMP_INDEX="$(mktemp)"
trap 'rm -f "$TMP_INDEX"' EXIT    # auto‑clean even on failure

write_header () {                 # $1 = titlebar, $2 = page‑title
  sed -e "s|{{TITLEBAR}}|$1|g" -e "s|{{TITLE}}|$2|g" "$HEADER"
}

get_excerpt () {               # $1 = markdown file
awk '
  BEGIN { FS=":"; in_fm = 0 }

  { sub(/\r$/, "") }                 # <‑‑‑ strip any trailing \r

  # ----- opening / closing fences -----
  NR==1 && $0 ~ /^---[[:space:]]*$/          { in_fm = 1; next }
  in_fm && $0 ~ /^---[[:space:]]*$/          { in_fm = 0; next }

  # ----- folded block  (excerpt: >) -----
  in_fm && $1=="excerpt" && $0~/^excerpt:[[:space:]]*>[[:space:]]*$/ {
      getline
      sub(/^[[:space:]]+/, "")
      print
      exit
  }

  # ----- single‑line excerpt -------------
  in_fm && $1=="excerpt" {
      $0 = substr($0, index($0, ":") + 1)
      gsub(/^[[:space:]]+|[[:space:]]+$/, "", $0)
      print
      exit
  }

  # ----- fallback: first body line -------
  !in_fm && NF { print; exit }
' "$1"
}


# tidy: remove old single‑post html files
find "$OUT_DIR" -maxdepth 1 -type f -name '*.html' ! -name 'index.html' -delete

for md in "$POST_SRC"/*.md; do
  slug="${md##*/}"; slug="${slug%.*}"
  dest="$OUT_DIR/$slug.html"

  # single awk harvests needed fields + fallback excerpt
  readarray -t meta < <(awk -F':' '
    /^title:/  {gsub(/^ +| +$/,"",$2); t=$2}
    /^date:/   {gsub(/^ +| +$/,"",$2); d=$2}
    /^cover:/  {gsub(/^ +| +$/,"",$2); sub(/#.*/,"",$2); c=$2}
    /^excerpt:/ {ex=1; next}
    ex && /^---/ {ex=0}
    ex || NR<=5 {e[++k]=$0}
    END{
      for(i=1;i<=3 && i in e;i++) print e[i];
      print t; print d; print c
    }' "$md")
# ----- excerpt ----------------------------------------------------
  excerpt=$(get_excerpt "$md")

  clean_excerpt=$(echo "$excerpt" | tr -d '\r'  | tr '\n' ' ' | tr -s ' ' | cut -c1-140) 

  title="${meta[3]}"
  date="${meta[4]}"
  cover="${meta[5]}"

  body="$(pandoc --from=gfm --to=html5 "$md")"

  {
    write_header "" "$title"
    [[ $cover ]] && printf '<div class="hero" style="background-image:url(%q);"></div>\n' "$cover"
    printf '<article>%s</article>\n' "$body"
    cat "$FOOTER"
  } > "$dest"

  printf '%s|%s|%s|%s|%s\n' \
         "$slug" "$title" "$date" "$cover" "$clean_excerpt" >> "$TMP_INDEX"

done

# ------------ build /blog/index.html -----------------
sitebar='jxins – Ruixin'\''s Blog'
{
  write_header "$sitebar" "Blog"
  echo '<style>.back-to-blog-wrapper{display:none}</style>'
  echo '<section class="post-grid">'
  sort -r "$TMP_INDEX" | while IFS='|' read -r slug ttl dte cov exc; do
    printf '<a class="post-card" href="/blog/%s.html">\n' "$slug"
    [[ $cov ]] && printf '  <figure><img loading="lazy" src="%s" alt=""></figure>\n' "$cov" \
               || printf '  <figure></figure>\n'
    printf '  <div class="post-content">\n    <h3>%s</h3>\n    <div class="post-meta">%s</div>\n    <p class="post-excerpt">%s</p>\n  </div>\n</a>\n' \
           "$ttl" "$dte" "$exc"
  done
  echo '</section>'
  cat "$FOOTER"
} > "$OUT_DIR/index.html"

echo "✅ Blog rebuilt at $(date)"
