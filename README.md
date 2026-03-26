## Project Overview

This repository provides a specialized build of **Ungoogled-Chromium** designed for developers of automation tools, anti-detect browsers, and multi-account managers. 

### 🛑 The Problem
Standard Chromium ignores proxy credentials passed via the command line for security reasons, forcing users to deal with a "Proxy Authentication Required" popup window that breaks automation scripts.

### ✅ The Solution
This patch modifies the **Network Stack (`net/http`)** to intercept authentication challenges. When the `--proxy-auth="user:pass"` flag is detected, the browser automatically injects the credentials, allowing for:
* **Headless/Automated Proxy Login:** No more manual interaction.
* **Massive Multi-Instance Scaling:** Launch hundreds of profiles, each with a unique, authenticated proxy.
* **Full Privacy:** Inherits all `ungoogled-chromium` features, stripping Google telemetry and host-detection.
