#!/bin/sh
# Author: abpwrs
# Sat Oct 20 16:55:03 CDT 2018
git push heroku master
./reset_heroku_db.sh
