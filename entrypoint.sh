#!/bin/bash

# Update
/usr/local/bin/update.sh

# Start postgres and lapis server
/etc/init.d/postgresql start &
cd /var/app
lapis server
