#!/bin/bash

sudo apt update -y

sudo apt install git nginx mysql-server curl -y

curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -

sudo apt install nodejs -y

cd myapp

npm install

sudo cp nginx.conf /etc/nginx/sites-available/default

sudo systemctl restart nginx

npm install -g pm2

pm2 start app.js

pm2 startup

pm2 save
