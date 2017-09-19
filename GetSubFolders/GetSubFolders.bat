@echo off
REM Purpose: Lists all folder in a given directory (non-recursive).
REM Usage: Change the values of "rootDirectory" prior to running this script


setlocal enableextensions enabledelayedexpansion

REM Change this paths
REM All folders/direcotries under this location will be listed
set rootDirectory="F:\Android\Apps"


REM Iterate through all app folder
for /D %%i in (%rootDirectory%\*) do (
	echo Processing: %%i
	set folderName=%%~ni%%~xi
	echo !folderName!>>Folders.txt
)

pause