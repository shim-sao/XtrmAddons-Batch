:: ################################################################################
:: @version		ssh.bat, build date : 16 aug. 2018
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
:: - BEGIN : Create UNIX commands for ssh.
::     - Add backup time.
::     - Add remote root path.
::     - Add database informations.
::     - Merge file with static UNIX commands.
::     - END : delete UNIX temp commands for ssh
:: - Perform ssh commans with PUTTY.
:: - Delete ssh commands after performing.
:: - BEGIN : ftp backup.
::     - Move to backup folder.
::     - Create ftp commands file & load remote zip file.
:: - Move to script folder
:: 
:: ################################################################################

:: --------------------------------------------------------
:: FTP - SOURCE PROCESS
:: --------------------------------------------------------

:: --------------------------------------------------------
:: Set files path
:: --------------------------------------------------------
set fileUnixTemp=%MBB_PATH_TEMP%\%dbSrcHost%_commands-tmp.sh
set fileUnixCmd=%MBB_PATH_TEMP%\%dbSrcHost%_unix-commands.sh
set shhFileUnixResult=%MBB_PATH_LOG%\%dbSrcHost%_unix-logs.log
set ftpFileDLTemp=%MBB_PATH_TEMP%\%dbSrcHost%_ftp-backup.cmd


:: --------------------------------------------------------
:: BEGIN Create UNIX commands for ssh.
:: Set the backuptime :
:: --------------------------------------------------------
echo # Set the backup time source informations>%fileUnixTemp%
echo backuptime=%backuptime%>>%fileUnixTemp%


:: --------------------------------------------------------
:: Set REMOTE path
:: --------------------------------------------------------
echo # Set the backup root folder>>%fileUnixTemp%
echo MBB_REMOTE_PATH=%MBB_REMOTE_PATH%>>%fileUnixTemp%


:: --------------------------------------------------------
:: Set the database informations
:: --------------------------------------------------------
echo # Set database source informations>>%fileUnixTemp%
echo dbSrcHost=%dbSrcHost%>>%fileUnixTemp%
echo dbSrcName=%dbSrcName%>>%fileUnixTemp%
echo dbSrcUser=%dbSrcUser%>>%fileUnixTemp%
echo dbSrcPassword=%dbSrcPassword%>>%fileUnixTemp%


:: --------------------------------------------------------
:: Merge file with static UNIX commands
:: --------------------------------------------------------
copy/b %fileUnixTemp%+%MBB_PATH_CMD%\unix\backup.sh %fileUnixCmd%


:: --------------------------------------------------------
:: END : delete UNIX temp commands for ssh
:: --------------------------------------------------------
del %fileUnixTemp%


:: --------------------------------------------------------
:: Perform ssh with PUTTY
:: --------------------------------------------------------
plink -v -ssh %sshHost% -pw %sshPassword% -m %fileUnixCmd% -l %sshUser% -P %sshPort% > %shhFileUnixResult%
del %fileUnixCmd%


:: --------------------------------------------------------
:: BEGIN ftp backup
:: Move to remote backup folder
:: --------------------------------------------------------
cd backup
cd remote

:: --------------------------------------------------------
:: Create sftp commands file, load remote zip file :
:: --------------------------------------------------------																  
echo cd /%MBB_REMOTE_PATH%/archives/>%ftpFileDLTemp%					
echo get "%dbSrcName%_%backuptime%.zip" "%dbSrcName%_%backuptime%.zip">>%ftpFileDLTemp%
echo quit>>%ftpFileDLTemp%
psftp %ftpUser%@%ftpHost% -P %ftpPort%  -pw "%ftpPassword%" -b "%ftpFileDLTemp%"
del %ftpFileDLTemp%

:: --------------------------------------------------------
:: Move to script folder
:: --------------------------------------------------------
dir
cd ..
cd ..