:: ################################################################################
:: @version		backup.cmd, build date : 16 aug. 2018
:: @package		MySQLBatchBackup
:: @subpackage	win
:: @copyright	Copyright (C) 2015+ XtrmAddons.COM. All rights reserved.
:: @license		GNU/GPL, see LICENSE.php
:: MySQLBatchBackup is free software. This version may have been modified pursuant
:: to the GNU General Public License, and as distributed it includes or
:: is derivative of works licensed under the GNU General Public License or
:: other free or open source software licenses.
:: See COPYRIGHT.php for copyright notices and details.
::
:: Description :
:: - Initilalize some local paths.
:: - Create tables list of the database into a file.
:: - Create local database temporary directory.
:: - Dump database tables in temporary directory.
:: - Dump database routines in temporary directory.
:: - Zipping all files ending in .sql in the backup folder
:: - Create remote database temporary directory.
:: - UnZipping all files ending in .sql in the temporary folder
::
::
:: ################################################################################

:: --------------------------------------------------------
:: LOCALHOST - DESTINATION PROCESS
:: --------------------------------------------------------

:: --------------------------------------------------------
:: Set some path
:: --------------------------------------------------------
set localMySQLFileTables=%MBB_PATH_TEMP%\%dbDestHost%.mysql-tables.sql
set localFileTables=%MBB_PATH_TEMP%\%dbDestHost%.mysql-tables.txt


:: --------------------------------------------------------
:: Set the tables list of the database into a file
:: --------------------------------------------------------
echo SHOW TABLES FROM `%dbDestName%`; > %localMySQLFileTables%
mysql.exe -h %dbDestHost% -u %dbDestUser% -p%dbDestPassword%  < %localMySQLFileTables% > %localFileTables%
erase %localMySQLFileTables%


:: --------------------------------------------------------
:: Create local database temporary directory
:: --------------------------------------------------------
if not exist %MBB_PATH_TEMP%\%dbDestName% (
	mkdir %MBB_PATH_TEMP%\%dbDestName%
)


:: --------------------------------------------------------
:: Dump database tables in temporary directory
:: --------------------------------------------------------
if exist %%F (
	for /F %%F in (%localFileTables%) do (
		if not [%%F]==[Tables_in_%dbDestName%] (
			set %%F=!%%F:@002d=-!
			mysqldump.exe -h %dbDestHost% -u %dbDestUser% -p%dbDestPassword% %dbDestName% %%F > %MBB_PATH_TEMP%\%dbDestName%\%%F_%backuptime%.sql
		) else (
			echo Skipping Tables_in_%dbDestName%
		)
	)
)


:: --------------------------------------------------------
:: Dump database routines in temporary directory
:: --------------------------------------------------------
mysqldump.exe -h %dbDestHost% -u %dbDestUser% -p%dbDestPassword% %dbDestName% %%F > %MBB_PATH_TEMP%\%dbDestName%\routines_%backuptime%.sql
erase %localFileTables%


:: --------------------------------------------------------
:: Create local database directory
:: --------------------------------------------------------
if not exist %MBB_PATH_BACKUP%\Local (
	mkdir %MBB_PATH_BACKUP%\Local
)


:: --------------------------------------------------------
:: Zipping all files ending in .sql in the local backup folder
:: --------------------------------------------------------
echo Zipping all files ending in .sql in the folder
7za a -tzip %MBB_PATH_BACKUP%\Local\%dbDestName%_%backuptime%.zip %MBB_PATH_TEMP%\%dbDestName%\*.sql
rmdir %MBB_PATH_TEMP%\%dbDestName% /s /q


:: --------------------------------------------------------
:: Create remote database directory
:: --------------------------------------------------------
if not exist %MBB_PATH_BACKUP%\remote (
	mkdir %MBB_PATH_BACKUP%\remote
)


:: --------------------------------------------------------
:: UnZipping all files ending in .sql in the temporary folder
:: --------------------------------------------------------
7za e %MBB_PATH_BACKUP%\remote\%dbSrcName%_%backuptime%.zip -o%MBB_PATH_TEMP%\%dbSrcName% *.sql -aoa


:: --------------------------------------------------------
:: Dump new data in local database & remove files at the end.
:: --------------------------------------------------------
for %%F in (%MBB_PATH_TEMP%\%dbSrcName%\*.sql) do (
	mysql.exe -h %dbDestHost% -u %dbDestUser% -p%dbDestPassword% %dbDestName% < %%F
)
rmdir %MBB_PATH_TEMP%\%dbSrcName% /s /q