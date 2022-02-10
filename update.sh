#!/bin/bash

# Copy files
cp -rf /var/source-code/* /var/app/
cd /var/app

# Compile app
moonc app.moon
