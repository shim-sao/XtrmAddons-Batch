:: ################################################################################
:: @version		backup-example.bat, build date : 12 sep. 2015
:: @package		MySQLBatchBackup
:: @subpackage	
:: @copyright	Copyright (C) 2015+ XtrmAddons.COM. All rights reserved.
:: @license		GNU/GPL, see LICENSE.php
:: MySQLBatchBackup is free software. This version may have been modified pursuant
:: to the GNU General Public License, and as distributed it includes or
:: is derivative of works licensed under the GNU General Public License or
:: other free or open source software licenses.
:: See COPYRIGHT.php for copyright notices and details.
:: ################################################################################

@echo off
setlocal

:: Import configuration :
set MBB_CONFIG_FILE=config.example.cmd

:: Backup to local database : yes/no
set MBB_PARAM_BACKUP=no

:: Call backup commands (do not remove)
call %CD%\backup.cmd

endlocal
pause