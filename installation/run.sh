#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PYTHON="${ROOT_DIR}/venv/bin/python"
BROWNIE="${ROOT_DIR}/venv/bin/brownie"

usage() {
  cat <<'EOF'
Usage:
  ./installation/run.sh ganache        Start Ganache on localhost:8545 (blocking)
  ./installation/run.sh compile        Compile contracts with Brownie
  ./installation/run.sh simulator      Run main.py (expects a chain on :8545)
  ./installation/run.sh reset          Delete local simulator state files
EOF
}

require_venv() {
  if [ ! -x "${PYTHON}" ]; then
    echo "Missing venv at ${ROOT_DIR}/venv. Run: ./installation/install.sh"
    exit 1
  fi
}

cmd="${1:-simulator}"

case "${cmd}" in
  ganache)
    if ! command -v npx >/dev/null 2>&1; then
      echo "npx is required to start Ganache (Node.js install)."
      exit 1
    fi
    GANACHE_MNEMONIC="${GANACHE_MNEMONIC:-test test test test test test test test test test test junk}"
    exec npx --yes ganache --server.port 8545 --chain.chainId 1337 --wallet.totalAccounts 10 --wallet.defaultBalance 1000 --wallet.mnemonic "${GANACHE_MNEMONIC}"
    ;;
  compile)
    require_venv
    if [ ! -x "${BROWNIE}" ]; then
      echo "Missing Brownie at ${BROWNIE}. Re-run: ./installation/install.sh"
      exit 1
    fi
    mkdir -p "${ROOT_DIR}/.home"
    (cd "${ROOT_DIR}/v3_core" && HOME="${ROOT_DIR}/.home" "${BROWNIE}" compile)
    ;;
  simulator)
    require_venv
    (cd "${ROOT_DIR}" && "${PYTHON}" main.py)
    ;;
  reset)
    rm -f "${ROOT_DIR}/model_storage/token_pool_addresses.json" "${ROOT_DIR}/model_storage/liq_positions.json"
    echo "Deleted model_storage/token_pool_addresses.json and model_storage/liq_positions.json"
    ;;
  -h|--help|help)
    usage
    ;;
  *)
    echo "Unknown command: ${cmd}"
    usage
    exit 2
    ;;
esac
