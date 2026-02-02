import argparse
import json
import os
import sys
import urllib.request
from pathlib import Path


def _rpc_is_up(url: str) -> bool:
    payload = {"jsonrpc": "2.0", "id": 1, "method": "eth_chainId", "params": []}
    req = urllib.request.Request(
        url,
        data=json.dumps(payload).encode(),
        headers={"Content-Type": "application/json"},
    )
    try:
        with urllib.request.urlopen(req, timeout=2) as r:
            body = r.read().decode()
        parsed = json.loads(body)
        return "result" in parsed
    except Exception:
        return False


def _parse_args(argv: list[str]) -> argparse.Namespace:
    p = argparse.ArgumentParser(prog="main.py")
    p.add_argument("--rpc-url", default="http://127.0.0.1:8545")
    p.add_argument("--token0", default="ALI")
    p.add_argument("--token1", default="USDC")
    p.add_argument("--token0-decimals", type=int, default=18)
    p.add_argument("--token1-decimals", type=int, default=6)
    p.add_argument("--fee-tier", type=int, default=3000)
    p.add_argument("--initial-pool-price", type=float, default=1.0)
    return p.parse_args(argv)


def main(argv: list[str]) -> int:
    args = _parse_args(argv)

    repo_root = Path(__file__).resolve().parent
    home_dir = repo_root / ".home"
    home_dir.mkdir(parents=True, exist_ok=True)
    os.environ["HOME"] = str(home_dir)

    if not _rpc_is_up(args.rpc_url):
        sys.stderr.write(
            "RPC is not reachable. Start Ganache first:\n"
            "  npx --yes ganache --server.port 8545 --chain.chainId 1337 "
            "--wallet.totalAccounts 10 --wallet.defaultBalance 1000\n"
        )
        return 1

    from UniV3Simulator import UniV3Simulator

    sim = UniV3Simulator(
        token0=args.token0,
        token1=args.token1,
        token0_decimals=args.token0_decimals,
        token1_decimals=args.token1_decimals,
        fee_tier=args.fee_tier,
        initial_pool_price=args.initial_pool_price,
    )

    print("pool", sim.pool.address)
    print("slot0", sim.pool.slot0())
    return 0


if __name__ == "__main__":
    raise SystemExit(main(sys.argv[1:]))
