#!/usr/bin/env bash

chown $UID /dev/stdout /dev/fd/1
chown -R $UID /home/$USERNAME

rm /tmp/.X*-lock

exec gosu $UID supervisord
