#!/bin/bash
NVIDIA_PATCH_REPO="${NVIDIA_PATCH_REPO:-$HOME/forks/nvidia-patch}"

echo "========================================"
echo "[$(date)] Start Nvidia patcher"
"$NVIDIA_PATCH_REPO/patch.sh"
echo "[$(date)] Start Nvidia FBC patcher"
"$NVIDIA_PATCH_REPO/patch-fbc.sh"
echo "[$(date)] Done"
