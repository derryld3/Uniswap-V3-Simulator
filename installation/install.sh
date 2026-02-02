#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if ! command -v curl >/dev/null 2>&1; then
  echo "curl is required"
  exit 1
fi

if ! command -v git >/dev/null 2>&1; then
  echo "git is required"
  exit 1
fi

if ! command -v uv >/dev/null 2>&1; then
  curl -LsSf https://astral.sh/uv/install.sh | sh
  if [ -f "${HOME}/.local/bin/env" ]; then
    source "${HOME}/.local/bin/env"
  else
    export PATH="${HOME}/.local/bin:${PATH}"
  fi
fi

uv python install 3.10
uv venv --python 3.10 --clear "${ROOT_DIR}/venv"
uv pip install -r "${ROOT_DIR}/requirements.txt" --python "${ROOT_DIR}/venv/bin/python"

if ! command -v node >/dev/null 2>&1; then
  export NVM_DIR="${HOME}/.nvm"
  mkdir -p "${NVM_DIR}"
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.2/install.sh | bash
  source "${NVM_DIR}/nvm.sh"
  nvm install 18
  nvm use 18
fi

mkdir -p "${ROOT_DIR}/.home"
(cd "${ROOT_DIR}/v3_core" && HOME="${ROOT_DIR}/.home" "${ROOT_DIR}/venv/bin/brownie" compile)

echo "Installed Python deps, ensured Node, and compiled contracts."
