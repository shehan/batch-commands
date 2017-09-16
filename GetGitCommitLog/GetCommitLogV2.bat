@echo off
REM Purpose: This script retrieves the Git commit history for a repository.
REM Prerequisites: All repositories are contained under the "mainRepo" directory. The commit log for each repository will be saved in a text file under the "commitLog" directory 
REM Usage: Change the values of "mainRepo" and "commitLog" prior to running this script

setlocal enableextensions enabledelayedexpansion

REM Change these paths
REM This location contains the cloned repositories
set mainRepo="C:\Projects\TestSmells"
REM This is the location where the log files will be created in
set commitLog=C:\Projects\android-repos\

REM Iterate through all app folder
for /D %%i in (%mainRepo%\*) do (
	echo Processing: %%i
	
	IF EXIST %%i\.git (
		REM This is a valid git repo
		
		cd %%i
		
		REM Build the path where the log file is to be created at
		set line=%%~ni
		set logFilePath=%commitLog%!line!.txt
		echo Creating log file: !logFilePath!
		
		REM Retrieve the commit log of the repo and write (overwite) to file
		REM Columns: 
		REM 	%H 	-> commit hash; 
		REM		%aI -> author date,strict ISO 8601 format; 
		REM		%aE -> author email; 
		REM		%cE -> committer email; 
		REM		%cI -> committer date, strict ISO 8601 format;
		REM		%s 	-> subject;
		REM		%b 	-> body;
		git log --full-history --pretty="%%H;%%aI;%%aE;%%cE;%%cI;%%s;%%b" --decorate=full > !logFilePath!
		
		REM remove blank lines from the file
		for /f "usebackq tokens=* delims=" %%a in (!logFilePath!) do (
			echo(%%a)>>~.txt
			move /y  ~.txt !logFilePath!
		
		) ELSE (
		REM Not a valid git repo. Do nothing
	)
)

pause