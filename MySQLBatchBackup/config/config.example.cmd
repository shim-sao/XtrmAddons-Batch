:: ################################################################################
:: @version		config.example.cmd, build date : 09 oct. 2017
:: @package		MySQLBatchBackup
:: @subpackage	config
:: @copyright	Copyright (C) 2015+ XtrmAddons.COM. All rights reserved.
:: @license		GNU/GPL, see LICENSE.php
:: MySQLBatchBackup is free software. This version may have been modified pursuant
:: to the GNU General Public License, and as distributed it includes or
:: is derivative of works licensed under the GNU General Public License or
:: other free or open source software licenses.
:: See COPYRIGHT.php for copyright notices and details.
:: 
:: @Description :
:: Configuration file for MySql databse import from remote server.
:: - Initialize database source informations to access MySQL remote server.
:: - Initialize database local informations to access MySQL local server.
:: - Initialize SSH paramaters to connect remote server for export.
:: - Initialize ftp parameters to connect remote server for import.
::
:: ################################################################################

:: --------------------------------------------------------
:: Set database source informations
:: --------------------------------------------------------
set dbSrcHost=[remote server address]
set dbSrcPort=[remote server port]
set dbSrcName=[remote database name]
set dbSrcUser=[remote database user name]
set dbSrcPassword=[remote database user password]


:: --------------------------------------------------------
:: Set database destination informations
:: --------------------------------------------------------
set dbDestHost=localhost
set dbDestName=[local database name]
set dbDestUser=root
set dbDestPassword=[local database user password]


:: --------------------------------------------------------
:: Set ssh parameters
:: --------------------------------------------------------
set sshHost=[remote server address]
set sshPort=[remote server port]
set sshUser=[remote ssh user name]
set sshPassword=[remote ssh user password]


:: --------------------------------------------------------
:: Set ftp parameters
:: --------------------------------------------------------
set ftpHost=[remote server address]
set ftpPort=[remote server port]
set ftpUser=[remote ftp user name]
set ftpPassword=[remote ftp user password]


:: --------------------------------------------------------
:: Set REMOTE path where data will be store :
:: You can remove comment and set your own remote directory.
:: Note : the folder will be automatically created at first start.
:: --------------------------------------------------------
:: set MBB_REMOTE_PATH=_backup/batch