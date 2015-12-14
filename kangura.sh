#!/bin/sh

function emailnotice {
    sendemail -o tls=yes -f vps@itemvirtual.com -t somemail@domain.com -s smtp.mandrillapp.com:587 -xu someemail@domain.com -xp password -u "$1" -o message-file="$2" >&-
}

MAILMAX=50
MAILQUEUE="$(/usr/sbin/postqueue -p | tail -n 1 | cut -d' ' -f5)"
LOGDATE="$(date +'%Y%m%d%H%M%S')"
HOSTNAMEIP="$(hostname -i)"

if [ "$MAILQUEUE" -gt "$MAILMAX" ]
    then
        mailq > /tmp/mailq_"$LOGDATE".log
        SUBJECT="$HOSTNAMEIP - Hi ha $MAILQUEUE correus de $MAILMAX permesos, aturat servei de correu"
        emailnotice "$SUBJECT" "/tmp/mailq_$LOGDATE.log"
        postfix stop >&-
fi

HOURMINUTES="$(date +'%H%M')"

if [ "$HOURMINUTES" == "0000" ]
    then
    find /var/www/blog.kangura.com/web -ctime 0 > /tmp/modified_files_"$LOGDATE".log
    find /var/www/kangura.com/web -ctime 0 >> /tmp/modified_files_"$LOGDATE".log
    emailnotice "Fitxers modificats les darreres 24 hores" "/tmp/modified_files_$LOGDATE.log"
fi



