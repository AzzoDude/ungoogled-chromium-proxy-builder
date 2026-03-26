# Ungoogled Chromium + Proxy-Auth Patch 🛡️
[![Engine](https://img.shields.io/badge/chromium-146.0-blue)](https://www.chromium.org)
[![Build Status](https://img.shields.io/badge/build-optimized-brightgreen)](#)
This repository provides a production-ready patch for **Ungoogled Chromium** that enables native proxy authentication via command-line arguments. This is the core engine for building multi-instance browser managers (like GenLogin).
## 🚀 Why This Project?
Standard Chromium ignores `user:pass` in the `--proxy-server` flag. This patch bypasses that restriction using a custom `--proxy-auth` switch, allowing for 100% automated proxy logins without popups.
---
## 🛠️ Build Instructions (Step-by-Step)
### 1. Prerequisites
* **Storage:** 100GB+ Free SSD space.
* **Tools:** Visual Studio 2022 (C++ Workload) + Windows 11 SDK.
* **Depot Tools:** Download and add to the **top** of your System PATH.
* **Env Var:** Set `DEPOT_TOOLS_WIN_TOOLCHAIN=0`.
### 2. Setup Source
```
mkdir chromium && cd chromium
fetch --nohooks chromium
cd src
```
### 3. Apply Patches
```
# Strip Google services
python3 ungoogled-chromium/utils/pruning.py .
python3 ungoogled-chromium/utils/patches.py apply . ungoogled-chromium/patches
# Apply Proxy-Auth Fix
git apply --ignore-whitespace proxy_auth.patch
```
