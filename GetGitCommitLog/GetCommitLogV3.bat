@echo off
REM Purpose: This script retrieves the Git commit history for a repository.
REM Prerequisites: All repositories are contained under the "mainRepo" directory. The commit log for each repository will be saved in a text file under the "commitLog" directory. There will only be one output file.
REM Usage: Change the values of "mainRepo" and "commitLog" prior to running this script

setlocal enableextensions enabledelayedexpansion

REM Change these paths
REM This location contains the cloned repositories
set mainRepo="C:\Projects\TestSmells"
REM This is the location where the log files will be created in
set commitLog=C:\Projects\batch-commands\GetGitCommitLog\commitLog.txt

REM Create output file and write column names
set columnNames=CommitHash;AbbreviatedCommitHash;AuthorDate;AuthorEmail;CommitterEmail;CommitterDate;Subject;Body
echo %columnNames%>%commitLog%

REM Iterate through all app folder
for /D %%i in (%mainRepo%\*) do (
	echo Processing: %%i
	
	IF EXIST %%i\.git (
		REM This is a valid git repo
		
		cd %%i
		set appName=%%~ni
		
		REM Retrieve the commit log of the repo and write (overwite) to file
		REM Columns: 
		REM 	%H 	-> commit hash; 
		REM 	%h 	-> abbreviated commit hash; 
		REM		%aI -> author date,strict ISO 8601 format; 
		REM		%aE -> author email; 
		REM		%cE -> committer email; 
		REM		%cI -> committer date, strict ISO 8601 format;
		REM		%s 	-> subject;
		REM		%b 	-> body;
		set gitCommand='git log --full-history --pretty="%%H;%%h;%%aI;%%aE;%%cE;%%cI;%%s;%%b" --decorate=full'

		REM Loop through the output of the git command and write (append) to file
		for /f "delims=" %%o in (!gitCommand!) do (
			echo !appName!;%%o>>!commitLog!
		)) ELSE (
		REM Not a valid git repo. Do nothing
	)
)

pause