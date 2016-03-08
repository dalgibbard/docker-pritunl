#!/bin/sh
set -e

[ -d /dev/net ] ||
    mkdir -p /dev/net
[ -c /dev/net/tun ] ||
    mknod /dev/net/tun c 10 200

touch /var/log/pritunl.log

touch /var/run/pritunl.pid

/bin/rm /var/run/pritunl.pid

/usr/local/bin/dumb-init mongod --fork --logpath /var/log/mongodb.log &
/usr/local/bin/dumb-init /usr/bin/pritunl start

[ "$1" ] && exec "$@"

