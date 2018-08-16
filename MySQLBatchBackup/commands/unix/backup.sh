# ################################################################################
# @version		backup.sh, build date : 09 oct. 2017
# @package		MySQLBatchBackup
# @subpackage	unix
# @copyright	Copyright (C) 2015+ XtrmAddons.COM. All rights reserved.
# @license		GNU/GPL, see LICENSE.php
# MySQLBatchBackup is free software. This version may have been modified pursuant
# to the GNU General Public License, and as distributed it includes or
# is derivative of works licensed under the GNU General Public License or
# other free or open source software licenses.
# See COPYRIGHT.php for copyright notices and details.
# 
# Description :
# Create MySQL database backup online on Linux Server.
# - Create some directories if not exists for backup operations.
# - Create table list in database.
# - Database Dump in a file (optional).
# - Dump of all tables in the database and store its into a zip file.
# - Remove archives older than 28 days in archives folder.
# - Clean up temp files & directories.
# 
# ################################################################################


# --------------------------------------------------------
# Set some path variables
# --------------------------------------------------------
bkPathTemp=${MBB_REMOTE_PATH}/temp
bkPathDB=${MBB_REMOTE_PATH}/temp/${dbSrcName}
bkPathStore=${MBB_REMOTE_PATH}/archives


# --------------------------------------------------------
# Create temp directory if not exists.
# --------------------------------------------------------
if [ ! -d $bkPathTemp ]
then
   mkdir -p $bkPathTemp
fi


# --------------------------------------------------------
# Create temp database directory if not exists.
# --------------------------------------------------------
if [ ! -d $bkPathDB ]
then
	mkdir -p $bkPathDB
fi


# --------------------------------------------------------
# Create store directory if not exists.
# --------------------------------------------------------
if [ ! -d $bkPathStore ]
then
	mkdir -p $bkPathStore
fi


# --------------------------------------------------------
# Set the tables list of the database into a file.
# Store it in the temp directory :
# --------------------------------------------------------
echo "SHOW TABLES FROM ${dbSrcName};" > ${bkPathTemp}/mysql-tables.sql
mysql -h $dbSrcHost -u $dbSrcUser -p$dbSrcPassword $dbSrcName < ${bkPathTemp}/mysql-tables.sql > ${bkPathTemp}/mysql-tables.txt


# --------------------------------------------------------
# Dump of the database :
# --------------------------------------------------------
# mysqldump -h $dbSrcHost -u $dbSrcUser -p$dbSrcPassword $dbSrcName > ${bkPathDB}/${dbSrcName}-${backuptime}.sql


# --------------------------------------------------------
# Dump of all tables in the database :
# --------------------------------------------------------
toIgnore=Tables_in_${dbSrcName}
cat ${bkPathTemp}/mysql-tables.txt | while read line
do
	if [ $line != $toIgnore ]
	then
	   mysqldump -h $dbSrcHost -u $dbSrcUser -p$dbSrcPassword $dbSrcName $line > ${bkPathDB}/${line}_${backuptime}.sql
	fi
done
mysqldump -h $dbSrcHost -u $dbSrcUser -p$dbSrcPassword --routines --no-create-info --no-data --no-create-db --skip-opt $dbSrcName > ${bkPathDB}/routines_${backuptime}.sql


# --------------------------------------------------------
# zip sql files in archives folder and remove its from the temp directory :
# --------------------------------------------------------
zip -j -r ${bkPathStore}/${dbSrcName}_${backuptime}.zip ${bkPathDB}
rm -f ${bkPathDB}/*.sql


# --------------------------------------------------------
# Remove archives older than 28 days in archives folder :
# --------------------------------------------------------
find ${bkPathStore} -type f -iname "*.zip" -mmin +40320 -exec rm -f {} \;


# --------------------------------------------------------
# Remove temporaries files & directories :
# --------------------------------------------------------
# rm -f ${bkPathTemp}/*.sql
# rm -f ${bkPathTemp}/*.txt
rm -rf ${bkPathTemp}


# --------------------------------------------------------
# list files and directories :
# --------------------------------------------------------
# ls -l