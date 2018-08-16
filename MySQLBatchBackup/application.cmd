:: ################################################################################
:: @version		application.cmd, build date : 16 aug. 2018
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
:: Application script to backup remote MySQL databases.
:: 
:: ################################################################################


:: --------------------------------------------------------
:: Add SCRIPT path
:: --------------------------------------------------------
set MBB_PATH=%cd%
set MBB_PATH_BACKUP=%MBB_PATH%\backup
set MBB_PATH_CMD=%MBB_PATH%\commands
set MBB_PATH_LOG=%MBB_PATH%\logs
set MBB_PATH_TEMP=%MBB_PATH%\temp
set MBB_PATH_ZIP=%MBB_PATH%\zip

:: --------------------------------------------------------
:: Create local script directories if required
:: --------------------------------------------------------
:: Create 'backup' directory
if not exist %MBB_PATH_BACKUP% (
	mkdir %MBB_PATH_BACKUP%
)
:: Create 'logs' directory
if not exist %MBB_PATH_LOG% (
	mkdir %MBB_PATH_LOG%
)
:: Create 'temp' directory
if not exist %MBB_PATH_TEMP% (
	mkdir %MBB_PATH_TEMP%
)

:: --------------------------------------------------------
:: Add REMOTE path for batch scpipts
:: --------------------------------------------------------
set MBB_REMOTE_PATH=_backup/batch


:: --------------------------------------------------------
:: Add PUTTY environnement path.
:: Uncomment the following line if the path does not exists
:: in the Windows environment variable PATH.
:: Choose between x86 or x64.
:: --------------------------------------------------------
:: set PATH=C:\Program Files (x86)\PuTTY;%PATH%
:: set PATH=C:\Program Files\PuTTY;%PATH%


:: --------------------------------------------------------
:: Add MySQL environnement path.
:: Uncomment the following line if the path does not exists
:: in the Windows environment variable PATH.
:: Set the path to your own MySQL installation here.
:: --------------------------------------------------------
:: set PATH=C:\Program Files\MySQL\MySQL Server 5.6\bin\;%PATH%


:: --------------------------------------------------------
:: Add 7zip environnement path.
:: Comment the following line if the path to the 7-Zip.exe
:: progrom exists in the Windows environment variable PATH.
:: --------------------------------------------------------
set PATH=%MBB_PATH_ZIP%;%PATH%