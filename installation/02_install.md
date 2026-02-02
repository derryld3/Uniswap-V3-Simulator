## Install

From the repo root:

```bash
cd Uniswap-V3-Simulator
chmod +x installation/install.sh
./installation/install.sh
```

What it does:

- Ensures `uv` exists (installs to `~/.local/bin` if missing)
- Installs Python 3.10 (via `uv`) and creates `./venv`
- Installs Python dependencies into `./venv`
- Ensures Node.js exists (installs via `nvm` if missing)
- Compiles contracts with Brownie (uses `./.home` as Brownie home)

Expected outputs:

- `venv/` exists in the repo root
- `v3_core/build/` exists after compilation
- `./.home/` exists (Brownie/solc cache isolated to this repo)
