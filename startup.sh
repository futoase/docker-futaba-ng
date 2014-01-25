#!/bin/sh

service nginx start

cd /root/futaba-ng/app/dest
php -S 0.0.0.0:3000 -t .
