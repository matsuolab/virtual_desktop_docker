#!/usr/bin/env bash

chown $LOCAL_UID /dev/stdout /dev/fd/1
chown -R $LOCAL_UID /home/$USERNAME

rm /tmp/.X*-lock

exec gosu $LOCAL_UID supervisord
