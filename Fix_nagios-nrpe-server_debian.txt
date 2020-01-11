# Debian 9 stretch has problem with systemd and nagios-nrpe-server package 3.2.x

# error
sty 11 09:53:03 localhost systemd[1]: nagios-nrpe-server.service: Main process exited, code=exited, status=127/n/a
sty 11 09:53:03 localhost systemd[1]: nagios-nrpe-server.service: Control process exited, code=exited status=127
sty 11 09:53:03 localhost systemd[1]: nagios-nrpe-server.service: Unit entered failed state.
sty 11 09:53:03 localhost systemd[1]: nagios-nrpe-server.service: Failed with result 'exit-code'.

# You should have nice start script in /etc/init.d/nagios-nrpe-server, just remove all systemd files
systemctl stop nagios-nrpe-server
systemctl disable nagios-nrpe-server
rm /lib/systemd/system/nagios-nrpe-server.service
systemctl reload-deamon
systemctl reset-failed

systemctl -a | grep nrpe
# should be empty, no nagios-nrpe-server serivce defined in systemd
# and now Y can use start script /etc/init.d/nagios-nrpe-server
/etc/init.d/nagios-nrpe-server stop
/etc/init.d/nagios-nrpe-server start

# /etc/init.d/nagios-nrpe-server
```sh
#! /bin/sh
#

### BEGIN INIT INFO
# Provides:          nagios-nrpe-server
# Required-Start:    $local_fs $remote_fs $syslog $named $network $time
# Required-Stop:     $local_fs $remote_fs $syslog $named $network
# Should-Start:
# Should-Stop:
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Start/Stop the Nagios remote plugin execution daemon
### END INIT INFO


PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
DAEMON=/usr/sbin/nrpe
NAME=nagios-nrpe
DESC=nagios-nrpe
CONFIG=/etc/nagios/nrpe.cfg
PIDDIR=/var/run/nagios

test -x $DAEMON || exit 0

if ! [ -x "/lib/lsb/init-functions" ]; then
        . /lib/lsb/init-functions
else
        echo "E: /lib/lsb/init-functions not found, lsb-base (>= 3.0-6) needed"
        exit 1
fi

# Include nagios-nrpe defaults if available
if [ -f /etc/default/nagios-nrpe-server ] ; then
        . /etc/default/nagios-nrpe-server
fi
# we also used to include this file, so if it's there
# we include it as well
if [ -f /etc/default/nagios-nrpe ]; then
        . /etc/default/nagios-nrpe
fi
if [ "$NICENESS" ]; then NICENESS="-n $NICENESS"; fi

#since /var/run can be wiped completly we create our run directory here
if [ ! -d "$PIDDIR" ]; then
        mkdir "$PIDDIR"
        chown nagios "$PIDDIR"
    [ -x /sbin/restorecon ] && /sbin/restorecon "$PIDDIR"
fi

set -e

case "$1" in
  start)
        if [ "$INETD" = 1 ]; then
                exit 0
        fi
        log_daemon_msg "Starting $DESC" "$NAME"
        start_daemon -p $PIDDIR/nrpe.pid $NICENESS $DAEMON  -c $CONFIG -d $NRPE_OPTS
        log_end_msg $?
        ;;
  stop)
        log_daemon_msg "Stopping $DESC" "$NAME"
        start-stop-daemon --stop --quiet --oknodo --pidfile $PIDDIR/nrpe.pid --retry 15
        log_end_msg $?
        ;;
  reload|force-reload)
        log_daemon_msg "Reloading $DESC configuration files" "$NAME"
        start-stop-daemon --stop --signal HUP --quiet --pidfile $PIDDIR/nrpe.pid
        log_end_msg $?
        ;;
  status)
    status_of_proc -p $PIDDIR/nrpe.pid "$DAEMON" "$NAME" && exit 0 || exit $?
    ;;
  restart)
        $0 stop
        sleep 1
        $0 start
        ;;
  *)
        log_failure_msg "Usage: $N {start|stop|restart|reload|force-reload}"
        exit 1
        ;;
esac

exit 0
```

