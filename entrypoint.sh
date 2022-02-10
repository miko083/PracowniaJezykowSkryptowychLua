#!/bin/bash

# Update
/usr/local/bin/update.sh

# Start server
cd /var/app
lapis server
