@echo off
setlocal enabledelayedexpansion

:: Set the path to the hosts file
set "HOSTS_FILE=%windir%\System32\drivers\etc\hosts"
set "SITE_LIST=sites"
set "COMMENT_PREFIX=#"
set "IP_ADDRESS=127.0.0.1 "


echo. >> %HOSTS_FILE%

:: Read each line from the "data" file
for /f "tokens=*" %%a in ('type "%SITE_LIST%"') do (
    :: Check if the line is not empty
    if not "%%a" == "" (
        :: Check if the line starts with '#'
        set "line=%%a"
        setlocal enabledelayedexpansion
        if "!line:~0,1!" == "%COMMENT_PREFIX%" (
            set "IP_ADDRESS="
            set "newline="
            echo. >> %HOSTS_FILE%
        ) 
        :: Add the appropriate prefix (if any) and append to the hosts file
        echo !IP_ADDRESS!!line!!newline! >> "%HOSTS_FILE%"
        echo Added !IP_ADDRESS!!line! to hosts file.
        endlocal
    )
)

echo All sites from "data" file have been added to the hosts file.

endlocal
