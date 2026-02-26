#!/usr/bin/env bash
set -euo pipefail

DESKFLOW_CORE="/var/home/ViMaSter/deskflow/build/bin/deskflow-core"

echo "Starting Deskflow client (uinput mode), connecting to ${DESKFLOW_SERVER}..."
exec "${DESKFLOW_CORE}" client --uinputx