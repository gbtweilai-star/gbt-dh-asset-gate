#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
PYTHONPATH=src python -m gbt_dh_asset_gate info
PYTHONPATH=src python -m gbt_dh_asset_gate check --payload '{}'
PYTHONPATH=src python -m gbt_dh_asset_gate run   --payload '{}'
