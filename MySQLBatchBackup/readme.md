# MySQLBatchBackup 1.4 [![fr-FR](https://github.com/shim-sao/XtrmAddons-Batch/blob/master/MySQLBatchBackup/images/france-flag-icon-16.png)](https://github.com/shim-sao/XtrmAddons-Batch/blob/master/MySQLBatchBackup/readme.fr-Fr.md)

MySQLBatchBackup is a series of scripts designs for backing up a remote UNIX database on a local WINDOWS server with SHH and SFTP protocols.

## 1 - Prerequisites

*   Have **[Putty](https://www.putty.org)** to be installed.
*   Download **[7-Zip](http://www.7-zip.org/)** or have to be installed.

Optional :

*   Have **[MySQL 5+](https://www.mysql.com)** to be installed.
-----------------------------

## 2 - Configure the application

*   Open the file **_application.cmd_** with a [text editor](https://notepad-plus-plus.org).
*   Check and change the folder path **MBB\_PATH\_ZIP** where is the software installation of **[7-Zip](https://www.7-zip.org/)** or place the executable in the directory named "zip".  
    Comment on adding to the Windows environment variable **PATH** if another folder path already exists.
*   Uncomment and check the folder path where the **[Putty](https://www.putty.org)** software installation is located if it is not already in the Windows environment variable **PATH**.
*   Uncomment and check the folder path where the **[MySQL 5+](https://www.mysql.com)** software installation is located if it is not already in the Windows environment variable **PATH**.
*   Save.
-----------------------------

## 3 - Configurer un backup ?

### Configure the servers and database :

*   In the directory **_config_** Copy/Paste the file **_config.example.cmd_** and rename it for example : **_config.monsite.cmd_**
*   Open the file **_config.monsite.cmd_** with a [text editor](https://notepad-plus-plus.org) and edit the following informations :  
    **dbSrc =** remote server. Example : 1&1  
    **dbDest =** local serveur.
*   Save.

### Create a launch file :

*   Copy/Paste the file **_backup-example.bat_** and rename it for example : **_backup-monsite.bat_**
*   Open the file **_backup-monsite.bat_** with a [text editor](https://notepad-plus-plus.org).
*   Edit the following lines :
*   **MBB\_CONFIG\_FILE** : Replace the file name with the one created previously.
*   **MBB\_PARAM\_BACKUP** : Enable or disable automatic import into the local database **(yes|no)**.  
    Notice, to do this **[MySQL 5+](https://www.mysql.com)** must be available.
*   Save.
-----------------------------

## 4 - Start the backup

*   Double click on **_backup-monsite.bat_** and follow the instructions.
-----------------------------