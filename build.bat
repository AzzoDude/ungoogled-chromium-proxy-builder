@echo off
echo [INFO] Starting Ungoogled-Chromium Build with Proxy-Auth Patch...

:: Apply Ungoogled Patches first
python3 ungoogled-chromium/utils/pruning.py .
python3 ungoogled-chromium/utils/patches.py apply . ungoogled-chromium/patches

:: Apply Custom Proxy Auth Patch
git apply --ignore-whitespace proxy_auth.patch

:: Setup Build Args
set ARGS=is_debug=false is_official_build=true symbol_level=0 blink_symbol_level=0 proprietary_codecs=true ffmpeg_branding="Chrome" target_cpu="x64"

echo [INFO] Generating Build Files...
call gn gen out\Release --args="%ARGS%"

echo [INFO] Compiling...
autoninja -C out\Release chrome
pause