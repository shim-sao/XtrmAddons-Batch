:: ################################################################################
:: @version		backup.bat, build date : 16 aug. 2018
:: @package		MySQLBatchBackup
:: @subpackage	
:: @copyright	Copyright (C) 2015+ XtrmAddons.COM. All rights reserved.
:: @license		GNU/GPL, see LICENSE.php
:: MySQLBatchBackup is free software. This version may have been modified pursuant
:: to the GNU General Public License, and as distributed it includes or
:: is derivative of works licensed under the GNU General Public License or
:: other free or open source software licenses.
:: See COPYRIGHT.php for copyright notices and details.
::
:: Description :
:: Backup script to backup remote MySQL databases.
:: 
:: ################################################################################

:: --------------------------------------------------------
:: Call environnement settings
:: --------------------------------------------------------
echo Calling environnement settings. Please wait...
call %CD%\application.cmd

:: --------------------------------------------------------
:: Begin of the script process
:: --------------------------------------------------------
echo %MBB_PATH% : Begin of process !

:: --------------------------------------------------------
:: Call date commands
:: --------------------------------------------------------
echo Calling date fotmat. Please wait...
call %MBB_PATH_CMD%\win\time.cmd


:: --------------------------------------------------------
:: Call config file : add your own path here !
:: --------------------------------------------------------
echo Calling config file. Please wait...
call %MBB_PATH%\config\%MBB_CONFIG_FILE%


:: --------------------------------------------------------
:: Process commands : store remote database and load it.
:: --------------------------------------------------------
echo Process commands : store remote database and download it. Please wait...
call %MBB_PATH_CMD%\win\ssh.cmd


:: --------------------------------------------------------
:: Process commands : store local database and replace it by remote download.
:: --------------------------------------------------------
if %MBB_PARAM_BACKUP% == yes (
	echo Replacing local database. Please wait...
	call %MBB_PATH_CMD%\win\backup.cmd
)


:: --------------------------------------------------------
:: End of the script process
:: --------------------------------------------------------
echo %MBB_PATH% : End of process !