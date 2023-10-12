@echo off
setlocal enabledelayedexpansion

set "HOSTS=C:\Windows\System32\drivers\etc\hosts"
set "TEMP_HOSTS=C:\Windows\System32\drivers\etc\hosts_tmp"
set "COMMENT_PREFIX=#"
set "IP_ADDRESS=127.0.0.1 "


if exist "%TEMP_HOSTS%" del "%TEMP_HOSTS%"

for /f "tokens=*" %%a in ('type "%HOSTS%"') do (
    set "LINE=%%a"
    set "SKIP_LINE=0"

    :: Check if the line is empty or starts with "127.0.0.1 " or starts with "#"
    if "!LINE!"=="" set "SKIP_LINE=1"
    if "!LINE:~0,10!"=="%IP_ADDRESS%" set "SKIP_LINE=1"
    if "!LINE:~0,1!"=="%COMMENT_PREFIX%" set "SKIP_LINE=1"

    :: Copy the line to the new file if it doesn't meet the skip criteria
    if !SKIP_LINE! equ 0 (
        echo !LINE!>>"%TEMP_HOSTS%"
    )
)
echo Copy completed. Output saved to %TEMP_HOSTS%.

:: remplace old hosts with new one
del "%HOSTS%" 2>nul
rename "%TEMP_HOSTS%" "hosts"
echo Successfully replaced hosts file with the updated version.

endlocal
