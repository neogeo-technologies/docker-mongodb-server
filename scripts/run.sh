#!/bin/bash

#enable job control in script
set -m

DATAPATH=${DATADIR:-/data}
mkdir -p $DATADIR/db
mkdir -p $DATADIR/log

# Configure MongoDB
if [ ! -f /data/db/.mongo_admin_created ]; then

	PASS=${SUPERPASS:-$(pwgen -s -1 16)}

	sed -i "s|dbPath: /data/db|dbPath: $DATAPATH/db|" /etc/mongod.conf
	sed -i "s|path: /data/log/mongod.log|path: $DATAPATH/log/mongod.log|" /etc/mongod.conf
fi

# Run MongoDB in background
/usr/bin/mongod --auth --config /etc/mongod.conf &

# Create admin user
if [ ! -f /data/db/.mongo_admin_created ]; then

	# If the superuser password is not defnied in an environment variable
	# it is randomly generated

	echo "SUPERUSER: \"$SUPERUSER\""
	echo "SUPERPASS: \"$PASS\""
 	echo "DATADIR: \"$DATAPATH\""

	RET=1
	while [[ RET -ne 0 ]]; do
	    echo "=> Waiting for confirmation of MongoDB service startup"
	    sleep 5
    	mongo admin --eval "help" >/dev/null 2>&1
	    RET=$?
	done

	mongo admin --eval "db.createUser({user: '$SUPERUSER', pwd: '$PASS', roles:[{role:'root',db:'admin'}]});"
	touch /data/db/.mongo_admin_created

	echo "========================================================================"
	echo "You can now connect to this MongoDB server using:"
	echo "    mongo admin -u $SUPERUSER -p $PASS --host <host> --port <port>"
	echo "========================================================================"
fi

# Bring MongoDB to foreground
fg