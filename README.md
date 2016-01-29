# docker-mongodb-server
Simple MongoDB server

Volumes déclarés :
- /data/db : stockage des données de MongoDB
- /data/log : stockage des logs de MongoDB

Configuration :
- le fichier de configuration utilisé par MongoDB est /etc/mongod.conf
- le port par défaut est utilisé : 27017
- aucune limitation sur l'IP du client
- aucune authentification nécessaire
- aucun utilisateur déclaré
- base de données vide (uniquement les bases de données par défaut sont présentes à la création du container)