:: ################################################################################
:: @version		openssl-certificat.bat, build date : 24 Oct. 2018
:: @package		OpensslBatchCertificate
:: @subpackage	win
:: @copyright	Copyright (C) 2018+ XtrmAddons.COM. All rights reserved.
:: @license		GNU/GPL, see LICENSE.php
:: OpensslBatchCertificate is free software. This version may have been modified pursuant
:: to the GNU General Public License, and as distributed it includes or
:: is derivative of works licensed under the GNU General Public License or
:: other free or open source software licenses.
::
:: IMPORTANT : To add OPENSSL_CONF permanently to the Windows environment
:: variables, this script must be execute as administrator.  
::
:: Description :
:: - Adding of the openssl.cnf to the Windows environment variable OPENSSL_CONF.
::   Required because Apache search for the file /usr/local/ssl/openssl.cnf by default
::   which not exists on Windows.
:: - Creation of a directory to store certificates Apache24\certificates
:: - Creation of an intermediate file for subjectAltName informations.
	 Required to happend subjectAltName to the Certificate Request when generating Certificate. 
:: - Creation of the Root Certificate Private Key file .key
	 This will be used as Root CA Private Key for all generated hostnames.
:: - Creation of the Root Certificate file .crt
	 This will be used as Root CA Certificate for all generated hostnames.
:: - Creation of the Host Certificate Request file .csr
:: - Creation of the Host Certificate Private Key file .key
:: - Creation of the Host Certificate .crt
:: - Final result of the process.
::
:: ################################################################################

@echo off
setlocal EnableDelayedExpansion


:: ------------------------------------------------------------------
:: CONFIGURATION
:: ------------------------------------------------------------------

:: 1 - Script environment
::
:: Replace here the name|path of the Apache 2.4 installation.
set APACHE_ROOT=C:\Apache24\

:: 2 - Informations for Certificate
::
:: Replace here the hostname for Certificate creation.
set HOSTNAME=example.com

:: 3 - Informations Transmitter
::
:: Replace here informations.
set VAR_C_FROM=FR
set VAR_O_FROM=Organization Transmitter
set VAR_OU_FROM=www.example.com
set VAR_ST_FROM=Nouvelle-Aquitaine
set VAR_L_FROM=Bordeaux

:: 3 - Informations Receiver
:: 
:: Replace here informations.
set VAR_C_TO=FR
set VAR_O_TO=Organization Receiver
set VAR_OU_TO=www.example.com
set VAR_ST_TO=Nouvelle-Aquitaine
set VAR_L_TO=Bordeaux

:: Some displays.
echo HOSTNAME=%HOSTNAME%
echo APACHE_ROOT=%APACHE_ROOT%

:: ------------------------------------------------------------------
:: PROCESS
:: ------------------------------------------------------------------

:: 1 - Initialize variables
::
:: Initialize Apache directories scheme.
set APACHE_BIN=%APACHE_ROOT%bin\
set APACHE_CONF=%APACHE_ROOT%conf\
set APACHE_CRT=%APACHE_ROOT%certificates\

:: Initialize required files names|path
set CA_KEY=%APACHE_CRT%ca.key
set CA_CRT=%APACHE_CRT%ca.crt
set HOST_CSR=%APACHE_CRT%%HOSTNAME%.csr
set HOST_CRT=%APACHE_CRT%%HOSTNAME%.crt
set HOST_KEY=%APACHE_CRT%%HOSTNAME%.key
set SN_TXT=%APACHE_CRT%%HOSTNAME%-sn.txt

:: 2 - Patch to create subjectAltName
::
:: Create intermediate file for subjectAltName.
:: The file is deleted at the end of the process.
echo subjectAltName=DNS:%HOSTNAME%,DNS:www.%HOSTNAME% > %SN_TXT%

:: 3 - Do execute
::
:: Create the certificates directory if not exists
:: because this directory is not present in Apache24
:: by default.
if not exist %APACHE_CRT% (
	mkdir %APACHE_CRT%
    echo "Create certificates directory. Done"
) else (
    echo "Create certificates directory. Skipped"
)

:: Add the path to httpd.exe temporaly to the Windows environment PATH.
:: Note: We can't add it permanently with setx because this
:: command truncate PATH to 1024 char. It's bad thing !
where /q httpd.exe
echo ERRORLEVEL=%ERRORLEVEL%
if "%ERRORLEVEL%" == "1" (
    set PATH=!APACHE_BIN!;!PATH!
    echo "Adding path to the Apache bin directory in the Windows environment variable PATH. Done."
) else (
    echo "Adding path to the Apache bin directory in the Windows environment variable PATH. Skipped."
)

:: Add openssl.conf path variable.
:: Because Apache use a Unix path for the Openssl configuration file,
:: we need to add it to the Windows environment variables.
:: openssl.conf path is required on Apache under the variable OPENSSL_CONF.
:: Note 1 : The path will be add to the Gobal environment,
:: remove /M to set it for User only.
:: Note 2 : Adding permanently environment variable required
:: to resart with another cmd to take effect.
set OPENSSL_CNF=!APACHE_CONF!openssl.cnf
if "%OPENSSL_CONF%" == "" (
    setx OPENSSL_CONF "!OPENSSL_CNF!" /M
    echo "Adding path to the Apache openssl.cnf in the Windows environment variable APACHE_CONF. Done."
    echo "To take effect the script must be restarted."
    echo "This Window will be closed."
    pause
    exit
) else (
    echo "Adding path to the Apache openssl.cnf in the Windows environment variable APACHE_CONF. Skipped."
)
echo OPENSSL_CNF =%OPENSSL_CNF%
echo OPENSSL_CONF=%OPENSSL_CONF%
echo:

:: Check the Version of openssl.exe
openssl version
echo:

:: Create Root CA private Key file : certificates\ca.key
if not exist %CA_KEY% (
	openssl genrsa -out %CA_KEY% 2048
	echo %CA_KEY% ... Done.
) else (
	echo %CA_KEY% ... Skipped.
)

:: Create Root CA Certificate file : certificates\ca.crt
:: This will be generated with an expiration of 1 year
if not exist %CA_CRT% (
	openssl req -new -x509 -days 365 -key %CA_KEY% -subj "/C=%VAR_C_FROM%/ST=%VAR_ST_FROM%/L=%VAR_L_FROM%/O=%VAR_O_FROM%, Inc./OU=%VAR_OU_FROM%/CN=Root CA" -out %CA_CRT%
	echo %CA_CRT% ... Done.
) else (
	echo %CA_CRT% ... Skipped.
)

:: Create Host Certificate Request file : certificates\hostname.csr.
openssl req -newkey rsa:2048 -nodes -keyout %HOST_KEY% -subj "/C=%VAR_C_TO%/ST=%VAR_ST_TO%/L=%VAR_L_TO%/O=%VAR_O_TO%, Inc./OU=%VAR_OU_TO%/CN=*.%HOSTNAME%" -out %HOST_CSR%
echo %HOST_CSR% ... Done.

:: Create the Host Certificate file : certificates\hostname.crt
:: This will be generated with an expiration of 1 year
openssl x509 -req -extfile %SN_TXT% -days 365 -in %HOST_CSR% -CA %CA_CRT% -CAkey %CA_KEY% -CAcreateserial -out %HOST_CRT%
echo %HOST_CRT% ... Done.
echo ----------------------------------------------------------------
echo:


:: Delete file which are not required no more.
del %HOST_CSR% /f
del %SN_TXT% /f
echo Deleting unnecessary files. Done.
echo:
pause


:: Displays Host Certificate informations.
openssl x509 -in %HOST_CRT% -text -noout
pause