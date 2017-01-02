#!/bin/bash

start-stop-daemon -x /usr/local/bin/ffserver -b -C -p /var/ffserver.pid -v --start -- -f /etc/ffserver.conf 
