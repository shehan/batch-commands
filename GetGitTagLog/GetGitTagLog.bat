@echo off
REM Purpose: This script retrieves the Git commit history for a repository.
REM Prerequisites: All repositories are contained under the "mainRepo" directory. The commit log for each repository will be saved in a text file under the "tagLog" directory. There will only be one output file.
REM Usage: Change the values of "mainRepo" and "tagLog" prior to running this script

setlocal enableextensions enabledelayedexpansion

REM Change these paths
REM This location contains the cloned repositories
set mainRepo="C:\Projects"
REM This is the location where the log files will be created in
set tagLog=C:\Projects\batch-commands\GetGitCommitLog\tagLog.txt

REM Create output file and write column names
set columnNames=App;TagName;ObjectType;ObjectName;CommitterEmail;CommitterDate;AuthorEmail;AuthorDate;Subject;Body
echo %columnNames%>%tagLog%

REM Iterate through all app folder
for /D %%i in (%mainRepo%\*) do (
	echo Processing: %%i
	
	IF EXIST %%i\.git (
		REM This is a valid git repo
		
		cd %%i
		set appName=%%~ni
		
		REM Retrieve the commit log of the repo and write (overwite) to file
		REM Columns: 
		REM refname:short -> tag name
		REM objecttype -> the type of the object (blob, tree, commit, tag)
		REM objectname -> SHA-1
		REM committeremail
		REM committerdate:iso8601
		REM authoremail
		REM authordate:iso8601
		REM contents:subject
		REM contents:body
		set gitCommand='git for-each-ref --format="%%(refname:short);%%(objecttype);%%(objectname);%%(committeremail);%%(committerdate:iso8601);%%(authoremail);%%(authordate:iso8601);%%(contents:subject);%%(contents:body)" refs/tags'

		REM Loop through the output of the git command and write (append) to file
		for /f "delims=" %%o in (!gitCommand!) do (
			echo !appName!;%%o>>!tagLog!
		)) ELSE (
		REM Not a valid git repo. Do nothing
	)
)

pause