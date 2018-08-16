:: ################################################################################
:: @version		time.bat, build date : 09 oct. 2017
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
:: Create formated date : yyyy-mm-dd_HH-MM
::
:: ################################################################################

:: --------------------------------------------------------
:: Get date and time parts
:: --------------------------------------------------------
set year=%DATE:~6,4%
set day=%DATE:~0,2%
set mnt=%DATE:~3,2%
set hr=%TIME:~0,2%
set min=%TIME:~3,2%

:: --------------------------------------------------------
:: Format date and time parts
:: --------------------------------------------------------
if %day% LSS 10 set day=0%day:~1,1%
if %mnt% LSS 10 set mnt=0%mnt:~1,1%
if %hr% LSS 10 set hr=0%hr:~1,1%
if %min% LSS 10 set min=0%min:~1,1%

:: --------------------------------------------------------
:: Set the backup date and time to formated string
:: --------------------------------------------------------
set backuptime=%year%-%mnt%-%day%_%hr%-%min%