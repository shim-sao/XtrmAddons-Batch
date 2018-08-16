# XtrmAddons MySQLBatchBackup 1.4 [![en-GB](https://github.com/shim-sao/XtrmAddons-Batch/blob/master/MySQLBatchBackup/images/united-kingdom-flag-icon-16.png)](https://github.com/shim-sao/XtrmAddons-Batch/blob/master/MySQLBatchBackup/readme.md)
================

MySQLBatchBackup est une série de scripts permettant de sauvegarder une base de données distante UNIX sur un serveur en local WINDOWS avec les protocoles SHH et SFTP.

1 - Prérequis
-------------

*   Avoir **[Putty](https://www.putty.org)** d'installé.
*   Télécharger **[7-Zip](http://www.7-zip.org/)** ou l'avoir d'installé.

Optionnel :

*   Avoir **[MySQL 5+](https://www.mysql.com)** d'installé.

## 2 - Configurer l'application
----------------------------

*   Ouvrir le fichier **_application.cmd_** avec un [éditeur de texte](https://notepad-plus-plus.org).
*   Vérifier et changer le chemin du dossier **MBB\_PATH\_ZIP** où se trouve l'installation du logiciel **[7-Zip](http://www.7-zip.org/)** ou placer l'executable dans le répertoire nommé "zip".  
    Commenter l'ajout à la variable d'environnement Windows **PATH** si un autre chemin de dossier existe déjà.
*   Décommenter et vérifier le chemin du dossier où se trouve l'installation du logiciel **[Putty](https://www.putty.org)** si celui ci ne se trouve pas déjà dans la variable d'environement Windows **PATH**.
*   Décommenter et vérifier le chemin du dossier où se trouve l'installation du logiciel **[MySQL 5+](https://www.mysql.com)** si celui ci ne se trouve pas déjà dans la variable d'environement Windows **PATH**.
*   Sauvegarder.

## 3 - Configurer un backup ?
--------------------------

### Configurer les serveurs et base de données :

*   Dans le dossier **_config_** Copier/Coller le fichier **_config.example.cmd_** et le renommer en par exemple : **_config.monsite.cmd_**
*   Ouvrir le fichier **_config.monsite.cmd_** avec un [éditeur de texte](https://notepad-plus-plus.org) et éditer les informations suivantes :  
    **dbSrc =** serveur distant. Exemple : 1&1  
    **dbDest =** serveur local.
*   Sauvegarder.

### Créer un fichier de lancement :

*   Copier/Coller le fichier **_backup-example.bat_** et le renommer en par exemple : **_backup-monsite.bat_**
*   Ouvrir le fichier **_backup-monsite.bat_** avec un [éditeur de texte](https://notepad-plus-plus.org).
*   Editer les lignes suivantes :
*   **MBB\_CONFIG\_FILE** : Remplacer le nom du fichier par celui créé précédemment.
*   **MBB\_PARAM\_BACKUP** : Activer ou non l'import automatique dans la base de donnée locale **(yes|no)**.  
    Noter que pour cela **[MySQL 5+](https://www.mysql.com)** doit être disponible.
*   Sauvegarder.

## 4 - Lancer le backup
--------------------

*   Double cliquer sur **_backup-monsite.bat_** et suivre les instructions.