# XtrmAddons OpensslBatchCertificate 1.0 [![fr-FR](https://github.com/shim-sao/XtrmAddons-Batch/blob/master/MySQLBatchBackup/images/france-flag-icon-16.png)](https://github.com/shim-sao/XtrmAddons-Batch/blob/master/OpensslBatchCertificate/readme.fr-Fr.md)

OpensslBatchCertificate is a script designs to create SSL certificate with OpenSSL and Windows.

## 1 - Prerequisites

IMPORTANT : To add **OPENSSL_CONF** permanently to the Windows environment variables, this script must be execute as administrator.

## 2 - Configure the application

*   Open the file **_openssl-certificate.bat_** with a [text editor](https://notepad-plus-plus.org).
*   Replace the **HOSTNAME** variable by the host name to associate to the certificate during creation.
*   Check the folder path **APACHE_ROOT** where the **[apache.exe](http://www.apache.org/dyn/closer.cgi)** software installation is located if it is not already in the Windows environment variable **PATH**.
*   Save.
-----------------------------

## 3 - Start the process

*   Double click on **_openssl-certificate.bat_** and follow the instructions.
*   The files generated during the creation process are added in a directory named **certificates** itself created in the **Apache24** directory like this **...\Apache24\certificates\[generated files keys, request and certificates]**
-----------------------------