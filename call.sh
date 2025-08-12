#!/usr/bin/env bash
set -e

# Default values
RHEL_AI_IMAGE_PAYLOAD="registry.redhat.io/rhelai1/instructlab-nvidia-rhel9:1.5.2-1750154648"
TOKENIZER_LOCATION="tokenizerfiles/granite-3.1-8b-starter-v2.1/tokenizer.json"
MAX_SEQ_LENGTH=$((10 * 1024))

# Parse named arguments
while [[ $# -gt 0 ]]; do
  case "$1" in
    --image)
      RHEL_AI_IMAGE_PAYLOAD="$2"
      shift 2
      ;;
    --tokenizer)
      TOKENIZER_LOCATION="$2"
      shift 2
      ;;
    --max-seq-length)
      MAX_SEQ_LENGTH="$2"
      shift 2
      ;;
    *)
      echo "Unknown option: $1"
      exit 1
      ;;
  esac
done

# Run podman and python commands
podman run -v ./replaybuffer/initial:/etc/replaybuffer --entrypoint cp "$RHEL_AI_IMAGE_PAYLOAD" -- /usr/share/instructlab/sdg/datasets/skills.jsonl /etc/replaybuffer/153-replay-buffer-skills.jsonl

python -u main.py "$TOKENIZER_LOCATION" replaybuffer/initial/153-replay-buffer-skills.jsonl replaybuffer/filtered/153-replay-buffer-skills.jsonl "$MAX_SEQ_LENGTH"
