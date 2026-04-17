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

## Demo

```powershell
powershell console> docker run -it pat-container
root@b84d2a473f6a:/pat/MONO-PAT-v3.6.0# ls
 Antlr3.Runtime.dll   Examples                                     Interop.VBIDE.dll   Microsoft.Contracts.dll              Microsoft.Msagl.dll                        'PAT 3.ini'            PAT.Editor.Docking.dll   PAT3.exe   ko            zh-CHS
 CUDDHelper.dll       ExtDLL                                       Lib                 Microsoft.Msagl.Drawing.dll          Microsoft.VisualStudio.TextTemplating.dll   PAT.Common.dll        PAT.Editor.dll           de         recents.xml   zh-CHT
 Docs                 Interop.Microsoft.Office.Interop.Excel.dll   License.dll         Microsoft.Msagl.GraphViewerGdi.dll   Modules                                     PAT.Editor.Core.dll   PAT3.Console.exe         ja         vi
root@b84d2a473f6a:/pat/MONO-PAT-v3.6.0# mono PAT3.Console.exe
Invalid arguments.For all modules except UML:
usage: PAT3.Console.exe [module] [options]* inputFile outputFile
module:
 -module short_name: Put the short_name of your module.
 -csp: Verification using CSP Module. If there is no module option, this is the default one.
 -rts: Verification using Real-Time System Module.
 -pcsp: Verification using Probabilistic CSP Module.
 -prts: Verification using Probabilistic Real-Time System Module.

For UML modules:
usage:
A: PAT3.Console.exe -uml  inputFile outputFile
It translates inputFile into a CSP# model and outputs the CSP# model to outputFile.
B: PAT3.Console.exe -uml [options]* inputFile1 inputFile2 outputFile
It translates inputFile1 and  inputFile2 into CSP# models and verifies the assertion <inputFile1 refines inputFile2> using CSP Module.
options:
 -b: (B)atch mode, the inputFile shall be the batch file containing lines of examples.
     Each line shall have the following format: -f inputFile
 -d: (D)irectory mode, the inputFile shall be the input directory name. All examples inside the directory will be executed.
     Please use only -b or -d.
 -behavior n: specify the admissible behavior as integer value n. Default value is 0.
 -engine n: specify the search engine as integer value n. Default value is 0.
 -help: print HELP information.
 -nc: (N)o (C)ounterexample display.
 -on: (O)n-the-fly Normalization. Suggest not to use, since static normalization is usually faster.
 -v: (V)erbose mode.
 -ver: (VER)sion.
root@b84d2a473f6a:/pat/MONO-PAT-v3.6.0# mono PAT3.Console.exe -pcsp /pat/
MONO-PAT-v3.6.0/        football_pressure.pcsp
root@b84d2a473f6a:/pat/MONO-PAT-v3.6.0# mono PAT3.Console.exe -pcsp /pat/
MONO-PAT-v3.6.0/        football_pressure.pcsp
root@b84d2a473f6a:/pat/MONO-PAT-v3.6.0# mono PAT3.Console.exe -pcsp /pat/football_pressure.pcsp ./output.log
PAT finished successfully.
root@b84d2a473f6a:/pat/MONO-PAT-v3.6.0# ls
 Antlr3.Runtime.dll   Examples                                     Interop.VBIDE.dll   Microsoft.Contracts.dll              Microsoft.Msagl.dll                        'PAT 3.ini'            PAT.Editor.Docking.dll   PAT3.exe   ko            vi
 CUDDHelper.dll       ExtDLL                                       Lib                 Microsoft.Msagl.Drawing.dll          Microsoft.VisualStudio.TextTemplating.dll   PAT.Common.dll        PAT.Editor.dll           de         output.log    zh-CHS
 Docs                 Interop.Microsoft.Office.Interop.Excel.dll   License.dll         Microsoft.Msagl.GraphViewerGdi.dll   Modules                                     PAT.Editor.Core.dll   PAT3.Console.exe         ja         recents.xml   zh-CHT
root@b84d2a473f6a:/pat/MONO-PAT-v3.6.0# cat ./output.log
=======================================================
Assertion: Match() reaches TeamAWins with prob
********Verification Result********
The Assertion (Match() reaches TeamAWins with prob) is Valid with Probability [0.44247, 0.44247];

********Verification Setting********
Admissible Behavior: All
Search Engine: Graph-based Probability Computation Based on Value Iteration
System Abstraction: False
Maximum difference threshold : 1E-06


********Verification Statistics********
Visited States:25616
Total Transitions:34025
MDP Iterations:1371890
Time Used:1.5647889s
Estimated Memory Used:66630.56KB


=======================================================
Assertion: Match() reaches TeamBWins with prob
********Verification Result********
The Assertion (Match() reaches TeamBWins with prob) is Valid with Probability [0.29715, 0.29715];

********Verification Setting********
Admissible Behavior: All
Search Engine: Graph-based Probability Computation Based on Value Iteration
System Abstraction: False
Maximum difference threshold : 1E-06


********Verification Statistics********
Visited States:25506
Total Transitions:33915
MDP Iterations:1384566
Time Used:0.777109s
Estimated Memory Used:67136.368KB


=======================================================
Assertion: Match() reaches Draw with prob
********Verification Result********
The Assertion (Match() reaches Draw with prob) is Valid with Probability [0.31483, 0.31483];

********Verification Setting********
Admissible Behavior: All
Search Engine: Graph-based Probability Computation Based on Value Iteration
System Abstraction: False
Maximum difference threshold : 1E-06


********Verification Statistics********
Visited States:27270
Total Transitions:36210
MDP Iterations:1249748
Time Used:0.7002496s
Estimated Memory Used:61842.72KB

```

---

## Environment Variables

| Variable   | Default                                 | Description                                 |
| ---------- | --------------------------------------- | ------------------------------------------- |
| `PAT_PATH` | `/pat/MONO-PAT-v3.6.0/PAT3.Console.exe` | Full path to the PAT3 console binary        |
| `TMPDIR`   | `/tmp`                                  | Temp dir for Mono (avoids WSL2 path issues) |

---

## Image Contents

| Path                          | Description                                     |
| ----------------------------- | ----------------------------------------------- |
| `/pat/MONO-PAT-v3.6.0/`       | PAT3 binaries, modules, and DLLs                |
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
