#!/usr/bin/env bash
podman cp registry.redhat.io/rhelai1/instructlab-nvidia-rhel9:1.5.2-1750154648:/usr/share/instructlab/sdg/datasets/skills.jsonl replaybuffer/initial/153-replay-buffer-skills.jsonl
python main.py tokenizerfiles/granite-3.1-8b-starter-v2.1/tokenizer.json replaybuffer/initial/153-replay-buffer-skills.jsonl replaybuffer/filtered/153-replay-buffer-skills.jsonl