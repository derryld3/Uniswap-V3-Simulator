## Run

### 1) Start a local chain (Ganache)

From the repo root, in a separate terminal:

```bash
bash installation/run.sh ganache
```

Keep it running.

### 2) Compile contracts (if you didn’t already)

```bash
bash installation/run.sh compile
```

### 3) Smoke-test the simulator

```bash
bash installation/run.sh simulator
```

### 4) Optional: stop/reset

- To reset state, stop Ganache and run:

```bash
bash installation/run.sh reset
```
