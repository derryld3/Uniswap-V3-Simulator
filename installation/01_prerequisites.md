## Prerequisites

These instructions assume you just cloned the repo and nothing else is installed.

### Required

- Git
- curl
- A POSIX shell (macOS Terminal, Linux shell, or Windows via WSL2)

### What this project uses

- Node.js + npm: used to run a local JSON-RPC chain (Ganache) via `npx`
- Python 3.10: used for Brownie + the simulator code

### Install Git and curl

- macOS:
  - Install Xcode Command Line Tools (provides git):
    ```bash
    xcode-select --install
    ```
  - curl is preinstalled on most macOS versions.

- Ubuntu/Debian:
  ```bash
  sudo apt-get update
  sudo apt-get install -y git curl
  ```

### Notes

- The install script in this folder installs:
  - `uv` (user-space Python toolchain manager) into `~/.local/bin`
  - Python 3.10 (user-space, via `uv`)
  - A virtual environment at `./venv`
  - Python dependencies from `requirements.txt`
  - Node.js (user-space, via `nvm`) if `node` is missing
