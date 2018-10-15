:: ################################################################################
:: @version		backup.cmd, build date : 14 Oct. 2018
:: @package		OpensslBatchCertificate
:: @subpackage	win
:: @copyright	Copyright (C) 2018+ XtrmAddons.COM. All rights reserved.
:: @license		GNU/GPL, see LICENSE.php
:: OpensslBatchCertificate is free software. This version may have been modified pursuant
:: to the GNU General Public License, and as distributed it includes or
:: is derivative of works licensed under the GNU General Public License or
:: other free or open source software licenses.
:: See COPYRIGHT.php for copyright notices and details.
::
:: IMPORTANT : To add OPENSSL_CONF permanently to the Windows environment
:: variables, this script must be execute as administrator.  
::
:: Description :
:: - Adding of the openssl.cnf to the Windows environment variable OPENSSL_CONF.
::   Required because Apache search for the file /usr/local/ssl/openssl.cnf by default
::   which not exists on Windows.
:: - Creation of a directory to store certificates Apache24\certificates
:: - Creation of the certificate request file .csr
:: - Creation of the certificate key file .key
:: - Creation of the certificate .crt
:: - Final result of the process.
::
:: ################################################################################

@echo off
setlocal EnableDelayedExpansion

:: ------------------------------------------------------------------
:: CONFIGURATION
:: ------------------------------------------------------------------

:: 1 - Informations for certificate
::
:: Replace here the hostname for certificate creation.
:: Be sure to type the same hostname when prompt as CN in process
set HOSTNAME=www.example.com

:: 2 - Script environment
::
:: Replace here the name|path of the Apache 2.4 installation.
set APACHE_ROOT=C:\Apache24\

echo HOSTNAME=%HOSTNAME%
echo APACHE_ROOT=%APACHE_ROOT%

:: ------------------------------------------------------------------
:: PROCESS
:: ------------------------------------------------------------------

:: 3 - Begin process 
::
:: Initialize Apache directories schema.
set APACHE_BIN=%APACHE_ROOT%bin\
set APACHE_CONF=%APACHE_ROOT%conf\
set APACHE_CRT=%APACHE_ROOT%certificates\

:: Initialize required files names|path
set CRT_REQUEST=%APACHE_CRT%%HOSTNAME%.csr
set HOSTCERTIFICATE=%APACHE_CRT%%HOSTNAME%.crt
set HOSTKEY=%APACHE_CRT%%HOSTNAME%.key

:: Create the certificates directory if not exists
:: because is not present in Apache24.
if not exist %APACHE_CRT% (
	mkdir %APACHE_CRT%
    echo "Create certificates directory. Done"
) else (
    echo "Create certificates directory. Skipped"
)

:: Add path to httpd.exe temporaly to the Windows PATH.
:: Note: We can't add it permanently with setx because 
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
:: we need to add it to the Windows environment variable.
:: openssl.conf path is required on Apache under the variable OPENSSL_CONF.
:: Note 1 : The path will be add to the Gobal environment,
:: remove /M to set it for User only.
:: Note 2 : Adding permanently environment variable required
:: to launch another cmd to take effect.
set OPENSSL_CNF=!APACHE_CONF!openssl.cnf
if "%OPENSSL_CONF%" == "" (
    setx OPENSSL_CONF "!OPENSSL_CNF!" /M
    echo "Adding path to the Apache openssl.cnf in the Windows environment variable APACHE_CONF. Done."
    echo "Take effect the script must be restarted."
    pause
    exit
) else (
    echo "Adding path to the Apache openssl.cnf in the Windows environment variable APACHE_CONF. Skipped."
)
echo OPENSSL_CNF=%OPENSSL_CNF%
echo OPENSSL_CONF=%OPENSSL_CONF%
echo:
pause

:: Check the version of openssl.exe
openssl version

:: Create certificate request file : certificates\www.example.com.csr
openssl req -new -out %CRT_REQUEST%

echo Create certificate request file : %HOSTNAME%.csr. Done.
echo ----------------------------------------------------------------
pause

:: Create private key : certificates\www.example.com.key
openssl rsa -in privkey.pem -out %HOSTKEY%

echo Create private key file. Done.
echo ----------------------------------------------------------------
pause

:: Create the certificate file : certificates\www.example.com.crt
:: with an expiration of 365 
openssl x509 -in %CRT_REQUEST% -out %HOSTCERTIFICATE% -req -signkey %HOSTKEY% -days 365

echo Create certificat with expiration. Done.
echo ----------------------------------------------------------------
echo:

:: Displays path of the files to be added to
:: the Apache ssl VIRTUALHOST
echo Certificat : /certificates/%HOSTNAME%.crt
echo %HOSTCERTIFICATE%
echo key : /certificates/%HOSTNAME%.key
echo %HOSTKEY%
echo:
echo End Process.
pause