# XtrmAddons OpensslBatchCertificate 2.0 [![fr-FR](https://github.com/shim-sao/XtrmAddons-Batch/blob/master/MySQLBatchBackup/images/france-flag-icon-16.png)](https://github.com/shim-sao/XtrmAddons-Batch/blob/master/OpensslBatchCertificate/readme.fr-Fr.md)

OpensslBatchCertificate is a script designs to create SSL certificate with OpenSSL and Windows.

## 1 - Prerequisites

IMPORTANT : To add **OPENSSL_CONF** permanently to the Windows environment variables, this script must be execute as administrator.-----------------------------

## 2 - Configure the application

*   Open the file **_openssl-certificate.bat_** with a [text editor](https://notepad-plus-plus.org).

*   Check the folder path **APACHE_ROOT** where the **[apache.exe](http://www.apache.org/dyn/closer.cgi)** software installation is located.
	
	APACHE_ROOT : Enter here the name|path of the Apache 2.4 installation directory.
	
*   Replace the **HOSTNAME** variable value by the host name to associate to the certificate during creation.

	HOSTNAME : Enter your hostname here.
	
*   Replace variables Informations Transmitter and Informations Receiver by your own informations.

	VAR_C  : Country ISO name 2 letters
	VAR_O  : Organization Name.
	VAR_OU : Optional organization departement name.
	VAR_ST : State or Region in the country.
	VAR_L  : Location or City.
	
*	Edit the following line to generate the variable ** subjectAltName ** if necessary.

	echo subjectAltName=DNS:%HOSTNAME%,DNS:www.%HOSTNAME% > %SN_TXT%
	
*   Save.
-----------------------------

## 3 - Start the process

*   Double click on **_openssl-certificate.bat_** and follow the instructions.
*   The files generated during the creation process are added in a directory named **certificates** itself created in the **Apache24** directory like this **...\Apache24\certificates\[generated files keys, request and certificates]**
-----------------------------