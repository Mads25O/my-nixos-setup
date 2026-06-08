find . -type f ! -name "flake.lock" ! -path "./.git/*" | sort | while read f; do
  echo "=== FILE: $f ==="
  cat "$f"
  echo ""
done
