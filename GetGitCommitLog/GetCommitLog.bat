REM Purpose: This script retrieves the Git commit history for a repository.
REM Prerequisites: All repositories are contained under the "mainRepo" directory. The commit log for each repository will be saved in a text file under the "commitLog" directory 
REM Usage: Change the values of "mainRepo" and "commitLog" prior to running this script

@echo off
setlocal enableextensions enabledelayedexpansion

REM Change these paths
REM This location contains the cloned repositories
set mainRepo="C:\Projects\ClonedRepos"
REM This is the location where the log files will be created in
set commitLog=C:\Projects\GitLogs\

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
		git log --name-status --reverse > !logFilePath!
		
	) ELSE (
		REM Not a valid git repo. Do nothing
	)
)

pause