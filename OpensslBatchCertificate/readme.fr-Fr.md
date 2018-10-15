# XtrmAddons OpensslBatchCertificate 1.0 [![en-GB](https://github.com/shim-sao/XtrmAddons-Batch/blob/master/MySQLBatchBackup/images/united-kingdom-flag-icon-16.png)](https://github.com/shim-sao/XtrmAddons-Batch/blob/master/OpensslBatchCertificate/readme.md)

OpensslBatchCertificate est un script conçu pour créer un certificat SSL avec OpenSSL et Windows.


## 1 - Prerequisites

IMPORTANT: Pour ajouter **OPENSSL_CONF** de manière permanente aux variables d'environnement Windows, ce script doit être exécuté en tant qu'administrateur.

## 2 - Configure the application

*   Ouvrir le fichier **_openssl-certificate.bat_** avec un [éditeur de texte](https://notepad-plus-plus.org).
*   Remplacez la variable **HOSTNAME** par le nom d'hôte à associer au certificat lors de la création.
*   Vérifier le chemin du dossier **APACHE_ROOT** où se trouve l'installation du logiciel **[apache.exe](http://www.apache.org/dyn/closer.cgi)** si celui ci ne se trouve pas déjà dans la variable d'environement Windows **PATH**.
*   Sauvegarder.
-----------------------------

## 4 - Start the backup

*   Double cliquer sur **_openssl-certificate.bat_** et suivre les instructions.
*   Les fichiers générés lors du processus de création sont ajoutés dans un répertoire nommé **certificates** lui même créé dans le répertoire **Apache24** comme ceci **/Apache24/certificates/[Fichiers générés clés, requêtes et certificats]**
-----------------------------