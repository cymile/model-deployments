#!/usr/bin/env bash
set -euo pipefail

BASE_DIR="apps/models/dev"
OUT_FILE="${BASE_DIR}/kustomization.yaml"

{
  echo "apiVersion: kustomize.config.k8s.io/v1beta1"
  echo "kind: Kustomization"
  echo "resources:"
} > "$OUT_FILE"

find "$BASE_DIR" -mindepth 1 -maxdepth 1 -type d | sort | while read -r dir; do
  name="$(basename "$dir")"
  if [[ -f "$dir/kustomization.yaml" ]]; then
    echo "  - ./${name}" >> "$OUT_FILE"
  fi
done
