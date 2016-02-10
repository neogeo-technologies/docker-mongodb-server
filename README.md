# docker-mongodb-server
Simple MongoDB server container

Volumes declared:
- /data/db: MongoDB db dir
- /data/log: MongoDB logs dir

## Configuration :
- MongoDB conf file: /etc/mongod.conf
- port : 27017 (the default MongoDB port)
- trusted environment (not any filter on ip)
- authentication  not configured
- no declared users
- no database


## Credits
Originally written for Fedora-Dockerfiles by scollier <scollier@redhat.com>

Ported by Adam Miller <maxamillion@fedoraproject.org> from https://github.com/fedora-cloud/Fedora-Dockerfiles

Adapted by Guillaume Sueur and Benjamin Chartier http://www.neogeo-online.net


## Using the simple mongodb client

A simple mongodb client is also available.
See https://github.com/neogeo-technologies/docker-mongodb-client


- run the data container :
```
docker run -v /data/db -v /data/log --name mongodb_data neogeo/mongodb-client echo "MongoDB /data/db and data/log"
```

- run the mongodb server container using the previously launched data container
```
docker run -d -p 27017:27017 --volumes-from mongodb_data --name mongodb_server neogeo/mongodb
```

- run a client container for accessing the data volumes of the data container : 
```
docker run -it --volumes-from mongodb_data --name mongodb_test neogeo/mongodb-client
```

- run a client container for using mongo shell tools (linked to the mongodb server container) :
```
docker run -it --name mongodb_client --link mongodb_server:mdbserver neogeo/mongodb-client
```