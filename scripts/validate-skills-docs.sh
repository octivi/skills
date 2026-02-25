#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="${1:-.}"
cd "$ROOT_DIR"

fail=0

error() {
  echo "ERROR: $*" >&2
  fail=1
}

check_skill_frontmatter() {
  local skill_file="$1"

  if [[ ! -f "$skill_file" ]]; then
    error "Missing required file: $skill_file"
    return
  fi

  local status=0
  awk '
    NR == 1 {
      if ($0 != "---") exit 10
      next
    }

    !frontmatter_done && /^---$/ {
      frontmatter_done = 1
      exit
    }

    !frontmatter_done {
      if ($0 ~ /^name:[[:space:]]*[^[:space:]].*/) has_name = 1
      if ($0 ~ /^description:[[:space:]]*.+/) has_description = 1
    }

    END {
      if (!frontmatter_done) exit 11
      if (!has_name) exit 12
      if (!has_description) exit 13
    }
  ' "$skill_file" || status=$?

  case "$status" in
    0) ;;
    10) error "$skill_file must start with YAML frontmatter delimiter ---" ;;
    11) error "$skill_file is missing closing YAML frontmatter delimiter ---" ;;
    12) error "$skill_file frontmatter is missing required field: name" ;;
    13) error "$skill_file frontmatter is missing required field: description" ;;
    *) error "$skill_file frontmatter validation failed with status $status" ;;
  esac
}

check_markdown_links() {
  local file="$1"

  while IFS= read -r md_link; do
    local target
    target="$(echo "$md_link" | sed -E 's/^!?\[[^]]+\]\(([^)]*)\)$/\1/')"
    target="${target%% *}"
    target="${target#<}"
    target="${target%>}"

    [[ -z "$target" ]] && continue
    [[ "$target" == \#* ]] && continue
    [[ "$target" =~ ^https?:// ]] && continue
    [[ "$target" =~ ^mailto: ]] && continue

    local path="${target%%#*}"
    [[ -z "$path" ]] && continue
    [[ "$path" == "..." ]] && continue

    local resolved
    if [[ "$path" == /* ]]; then
      resolved=".$path"
    else
      resolved="$(dirname "$file")/$path"
    fi

    if [[ ! -e "$resolved" ]]; then
      error "Broken local link in $file: $target"
    fi
  done < <(grep -oE '!?\[[^]]+\]\([^)]+\)' "$file" || true)
}

mapfile -t skill_dirs < <(
  find . -mindepth 1 -maxdepth 1 -type d ! -name '.*' ! -name 'scripts' -printf '%P\n' | sort
)

if [[ "${#skill_dirs[@]}" -eq 0 ]]; then
  error "No skill directories found at repository root."
fi

for skill_dir in "${skill_dirs[@]}"; do
  check_skill_frontmatter "$skill_dir/SKILL.md"
done

doc_files=()
for root_doc in README.md AGENTS.md CONTRIBUTING.md; do
  if [[ -f "$root_doc" ]]; then
    doc_files+=("$root_doc")
  fi
done

for skill_dir in "${skill_dirs[@]}"; do
  if [[ -f "$skill_dir/README.md" ]]; then
    doc_files+=("$skill_dir/README.md")
  fi
  doc_files+=("$skill_dir/SKILL.md")
  if [[ -d "$skill_dir/references" ]]; then
    while IFS= read -r ref_file; do
      doc_files+=("$ref_file")
    done < <(find "$skill_dir/references" -maxdepth 1 -type f -name '*.md' | sort)
  fi
done

for doc_file in "${doc_files[@]}"; do
  check_markdown_links "$doc_file"
done

if [[ "$fail" -ne 0 ]]; then
  echo "Validation failed." >&2
  exit 1
fi

echo "Validation succeeded."
