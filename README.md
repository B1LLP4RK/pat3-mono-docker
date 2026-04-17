# PAT3 Mono Docker Image

A ready-to-use Docker image for running **PAT 3.6 (Process Analysis Toolkit)** on Linux via **Mono**, without needing Wine or a Windows host.

Intended for use in **CS4211 (Program Correctness)** coursework involving PCSP# / CSP# probabilistic model checking.

---

## Docker Hub

```
docker pull junha1109/pat3-mono:latest
```

---

## Quick Start

### Run an interactive shell inside the container

```bash
docker run --rm -it junha1109/pat3-mono:latest bash
```

### Verify PAT3 works

```bash
docker run --rm junha1109/pat3-mono:latest \
  mono /pat/MONO-PAT-v3.6.0/PAT3.Console.exe --help
```

### Run a PCSP# model from your host machine

```bash
docker run --rm \
  -v /path/to/your/model.pcsp:/model.pcsp \
  junha1109/pat3-mono:latest \
  mono /pat/MONO-PAT-v3.6.0/PAT3.Console.exe -pcsp /model.pcsp
```

A sample model (`football_pressure.pcsp`) is included in the image at `/pat/football_pressure.pcsp`.

---

## Environment Variables

| Variable   | Default                                      | Description                          |
|------------|----------------------------------------------|--------------------------------------|
| `PAT_PATH` | `/pat/MONO-PAT-v3.6.0/PAT3.Console.exe`     | Full path to the PAT3 console binary |
| `TMPDIR`   | `/tmp`                                        | Temp dir for Mono (avoids WSL2 path issues) |

---

## Image Contents

| Path                          | Description                                      |
|-------------------------------|--------------------------------------------------|
| `/pat/MONO-PAT-v3.6.0/`      | PAT3 binaries, modules, and DLLs                |
| `/pat/football_pressure.pcsp` | Sample PCSP# model (CS4211 agentic soccer demo) |

---

## Building Locally

```bash
git clone https://github.com/junha1109/pat3-mono-docker
cd pat3-mono-docker
docker build -t pat3-mono .
```

---

## Notes

- Base image: `mono:6.12`
- PAT version: 3.6.0
- No GUI required — uses `PAT3.Console.exe` for headless verification
- Compatible with Linux containers on Docker Desktop (Windows/Mac) and native Linux
