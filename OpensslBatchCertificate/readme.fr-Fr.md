# XtrmAddons OpensslBatchCertificate 2.0 [![en-GB](https://github.com/shim-sao/XtrmAddons-Batch/blob/master/MySQLBatchBackup/images/united-kingdom-flag-icon-16.png)](https://github.com/shim-sao/XtrmAddons-Batch/blob/master/OpensslBatchCertificate/readme.md)

OpensslBatchCertificate est un script conçu pour créer un certificat SSL avec OpenSSL et Windows.


## 1 - Prerequisites

IMPORTANT : Pour ajouter **OPENSSL_CONF** de manière permanente aux variables d'environnement Windows, ce script doit être exécuté en tant qu'administrateur.-----------------------------

## 2 - Configurer l'application

*   Ouvrir le fichier **_openssl-certificate.bat_** avec un [éditeur de texte](https://notepad-plus-plus.org).

*   Vérifier le chemin du dossier **APACHE_ROOT** où se trouve l'installation du logiciel **[apache.exe](http://www.apache.org/dyn/closer.cgi)**.
	
	APACHE_ROOT : Entrez le nom|chemin du répertoire d'installation Apache 2.4.
	
*   Remplacer la valeur de la variable **HOSTNAME** par le nom d'hôte à associer au certificat lors de la création.

	HOSTNAME : Entrez le nom de l'hôte ici.
	
*   Remplacer les variables Informations Transmitter and Informations Receiver par ses propres informations.

	VAR_C  : Nom Pays ISO 2 letters
	VAR_O  : Nom de l'Organisation.
	VAR_OU : Nom du Département de l'Organisation Optionel.
	VAR_ST : Etat ou Region dans le pays.
	VAR_L  : Localisation ou Ville.
	
*	Modifier la ligne suivante pour générer la variable **subjectAltName** si besoin.

	echo subjectAltName=DNS:%HOSTNAME%,DNS:www.%HOSTNAME% > %SN_TXT%
	
*   Sauvegarder.
-----------------------------

## 3 - Démarrer le processus

*   Double cliquer sur **_openssl-certificate.bat_** et suivre les instructions.
*   Les fichiers générés lors du processus de création sont ajoutés dans un répertoire nommé **certificates** lui même créé dans le répertoire **Apache24** comme ceci **/Apache24/certificates/[Fichiers générés clés, requêtes et certificats]**
-----------------------------