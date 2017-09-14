REM Purpose: This script performs a recursive directory search for all files with a specified extension. The output is displayed on the screen and also written (appended) to a file.
REM Usage: Call this file and pass two arguments - the root folder to start searching from and the file extension
REM Example: fileExtensionSearch.bat "G:\TestSmellDetector" "*.java"   <-- this will recursively search for all java files in the specified directory

@echo off
setlocal enableextensions enabledelayedexpansion
call :find-files %1 %2
echo PATHS: %PATHS%
echo NAMES: %NAMES%
goto :eof

:find-files
    set PATHS=
    set NAMES=
    for /r "%~1" %%P in ("%~2") do (
        set PATHS=!PATHS! "%%~fP"
        set NAMES=!NAMES! "%%~nP%%~xP"
		echo "%%~fP">>Results_FilePath.txt
    )
goto :eof