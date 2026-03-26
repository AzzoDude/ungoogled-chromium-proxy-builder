# Ungoogled Chromium + Proxy-Auth Patch 🛡️

This repository provides a production-ready patch for **Ungoogled Chromium** that enables native proxy authentication via command-line arguments. This is the core engine for building multi-instance browser managers (like GenLogin).

---

## 🚀 Why This Project?

Standard Chromium ignores `user:pass` in the `--proxy-server` flag. This patch bypasses that restriction using a custom `--proxy-auth` switch, allowing for **100% automated proxy logins** without annoying authentication popups.

> [!TIP]
> Effectively eliminates the "Sign In" popups when managing dozens of browser instances simultaneously.

---

## 📂 Required Directory Structure

Before building, ensure your workspace is organized exactly like this:

```plaintext
C:/your_workspace/
├── depot_tools/             <-- Google build tools
└── chromium/
    └── src/                 <-- Main
        ├── build.bat        <-- Your build script (move here)
        ├── proxy_auth.patch <-- Your custom patch (move here)
        └── ungoogled-chromium/  <-- Clone/Move this folder HERE
            ├── patches/     <-- Privacy patches
            └── utils/       <-- Pruning & patching scripts
```

---

## 🛠️ Build Instructions (Step-by-Step)

### 1. Prerequisites & System Setup
You must follow the official Google environment setup first:

*   **Official Guide:** [Chromium Windows Build Instructions](https://chromium.googlesource.com/chromium/src/+/main/docs/windows_build_instructions.md)
*   **Storage:** 100GB+ Free SSD space.
*   **Tools:** Visual Studio 2022 (Install "Desktop development with C++" + "Windows 11 SDK 10.0.22621.0").
*   **Depot Tools:** 
    *   Download `depot_tools.zip`.
    *   Extract to `C:\depot_tools`.
    *   Add `C:\depot_tools` to the **TOP** of your System PATH.
*   **Env Var:** Open CMD and set:
    ```cmd
    set DEPOT_TOOLS_WIN_TOOLCHAIN=0
    ```

### 2. Setup Source
Download the Chromium source code (Note: This takes significant time and bandwidth):

```bash
mkdir chromium && cd chromium
fetch --nohooks chromium
cd src
```

### 3. Apply Patches
Ensure this repo's files and the `ungoogled-chromium` folder are inside `src/`, then run:

```bash
# 1. Strip Google binaries & services
python3 ungoogled-chromium/utils/pruning.py .

# 2. Apply Ungoogled privacy patches
python3 ungoogled-chromium/utils/patches.py apply . ungoogled-chromium/patches

# 3. Apply the Proxy-Auth Fix
git apply --ignore-whitespace proxy_auth.patch
```

### 4. Compile (Final Product Mode)

```bash
# Generate Optimized GN Config
gn gen out\Release --args="is_debug=false is_official_build=true symbol_level=0 blink_symbol_level=0 proprietary_codecs=true ffmpeg_branding=\"Chrome\" target_cpu=\"x64\""

# Start Ninja Build (Takes 3-8 hours)
autoninja -C out\Release chrome
```

---

## 📖 Usage Guide

To launch a specific profile with an authenticated proxy:

```bash
chrome.exe --proxy-server="1.2.3.4:8080" --proxy-auth="username:password" --user-data-dir="C:\Profiles\Profile_01"
```

### CLI Flags Reference

| Flag | Purpose |
| :--- | :--- |
| `--proxy-server` | Proxy IP and Port. |
| `--proxy-auth` | **[NEW]** Your `user:pass` credentials. |
| `--user-data-dir` | Keeps cookies/cache separate for this instance. |

---

> [!CAUTION]
> This build is intended for automation and research purposes. Ensure you comply with the terms of service of the websites you interact with.
