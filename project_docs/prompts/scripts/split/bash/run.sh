#!/usr/bin/env bash
set -e

INPUT="$1"
OUTDIR="$2"
LOGFILE="$3"

cd "$(dirname "$INPUT")"

awk -v outdir="$(realpath "$OUTDIR")" '
  BEGIN { RS="---\n+"; FS="\n" }
  /^### Tarea/ {
    block = $0
    gsub(/[\r\n]+$/, "", block)
    for (i = 1; i <= NF; i++) {
      if ($i ~ /^### Tarea/) {
        split($i, header, ": ")
        tarea_id = header[1]
        title = header[2]
        gsub(/ /, "_", title)
        gsub(/[^a-zA-Z0-9_-]/, "", title)
        gsub(/^### Tarea /, "", tarea_id)
        filename = tarea_id "-" title ".md"
        path = outdir "/" filename
        print block > path
        print "📝 " filename
        close(path)
        break
      }
    }
  }
' "$INPUT" | tee "$LOGFILE"
