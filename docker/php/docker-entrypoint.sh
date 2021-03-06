#!/usr/bin/env ash

# set up authenticating SMTP...
if [ -n "$PHP_MAIL_HOST" ] ; then
    if ! [ -e /etc/msmtprc ] ; then
        echo >&2 "writing /etc/msmtprc"
        tee <<EOF > /etc/msmtprc
#
# This was generated by a template in the entrypoint.sh script
# to create a valid msmtprc configuration with environment
# variables set in your docker-compose.yml file.
#
# For more quirky configurations, this might require some
# manual tweaking.
#
# easy docker container outgoing mail
defaults
logfile /tmp/msmtp.log

# this assumes that the SMTP server has TLS... which
# any modern server should...
tls on
tls_trust_file /etc/ssl/certs/ca-certificates.crt

account RemoteHost

# server details
host $PHP_MAIL_HOST
from $PHP_MAIL_FROM
port $PHP_MAIL_PORT

# SMTP authentication details
auth on
user $PHP_MAIL_USERNAME
password $PHP_MAIL_PASSWORD
account default : RemoteHost
EOF
    else
        echo >&2 "/etc/msmtprc already in place! Not overwriting."
    fi
else
    echo >&2 "not configuring MSMTP - set SMTP_HOST and related environment values to enable."
fi

exec "$@"