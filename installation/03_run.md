## Run

### 1) Start a local chain (Ganache)

From the repo root, in a separate terminal:

```bash
cd Uniswap-V3-Simulator
npx --yes ganache --server.port 8545 --chain.chainId 1337 --wallet.totalAccounts 10 --wallet.defaultBalance 1000
```

Keep it running.

### 2) Compile contracts (if you didn’t already)

```bash
cd Uniswap-V3-Simulator
ROOT="$(pwd)"
cd v3_core
HOME="$ROOT/.home" "$ROOT/venv/bin/brownie" compile
```

### 3) Smoke-test the simulator

```bash
cd Uniswap-V3-Simulator
./venv/bin/python main.py
```

### 4) Optional: stop/reset

- To reset state, stop Ganache and delete these files:
  - `model_storage/token_pool_addresses.json`
  - `model_storage/liq_positions.json`
