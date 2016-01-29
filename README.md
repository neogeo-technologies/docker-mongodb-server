# docker-mongodb-server
Simple MongoDB server

## Volumes déclarés :
- /data/db : stockage des données de MongoDB
- /data/log : stockage des logs de MongoDB

## Configuration :
- le fichier de configuration utilisé par MongoDB est /etc/mongod.conf
- le port par défaut est utilisé : 27017
- aucune limitation sur l'IP du client
- aucune authentification nécessaire
- aucun utilisateur déclaré
- base de données vide (uniquement les bases de données par défaut sont présentes à la création du container)


## Credits
Originally written for Fedora-Dockerfiles by scollier <scollier@redhat.com>

Ported by Adam Miller <maxamillion@fedoraproject.org> from https://github.com/fedora-cloud/Fedora-Dockerfiles

Adapted by Guillaume Sueur and Benjamin Chartier http://www.neogeo-online.net

## Using the simple mongodb client

A simple mongodb client is available in the resources/docker-mongodb-client subdirectory.


volume container :
docker run -v /data/db -v /data/log --name mongodb-data neogeo/mongodb-client echo "MongoDB /data/db and data/log"

mongodb server container
docker run -d -p 27017:27017 --volumes-from mongodb-data --name mongodb-server neogeo/mongodb-server

client container for accessing the data volumes : 
docker run -it --volumes-from mongodb-data --name mongodb-test neogeo/mongodb-client

client container for using mongo shell tools :
docker run -it --name mongodb-client --link mongodb-server:mdbserver neogeo/mongodb-client