#!/bin/bash

if (( $(ps -ef | grep -v grep | grep postfix | wc -l) > 0 ))
	then
		POSTFIX=1
	else
		POSTFIX=0
	fi

if (( $(ps -ef | grep -v grep | grep imap-login | wc -l) > 0 ))
	then
		IMAP=1
	else
		IMAP=0
	fi

if (( $(ps -ef | grep -v grep | grep pure-ftpd | wc -l) > 0 ))
	then
		FTP=1
	else
		FTP=0
	fi


if (( $(ps -ef | grep -v grep | grep apache2 | wc -l) > 0 ))
	then
		APACHE=1
	else
		APACHE=0
	fi

if (( $(ps -ef | grep -v grep | grep apache2 | wc -l) > 0 ))
then
	MYSQL=1
else
	MYSQL=0
fi

DIKSAVAILABLE="$(df -h / | grep 'simfs' | sed 's/ \+/ /g' | cut -d" " -f 4)"

DISKUSAGE="$(df -h / | grep 'simfs' | sed 's/ \+/ /g' | cut -d" " -f 3)"

MAILQUEUE="$(postqueue -p | tail -n 1 | cut -d' ' -f5)"

HOST="$(hostname -i)"

UPTIME="$(cut -d ' ' -f1 /proc/uptime )"

echo "MYSQL=$MYSQL&POSTFIX=$POSTFIX&IMAP=$IMAP&FTP=$FTP&APACHE=$APACHE&DISKUSAGE=$DISKUSAGE&DISKAVAILABLE=$DIKSAVAILABLE&MAILQUEUE=$MAILQUEUE&HOST=$HOST&UPTIME=$UPTIME"
#curl --data "SMTP=$SMTP&IMAP=$IMAP&FTP=$FTP&APACHE=$APACHE&DISKUSAGE=$DISKUSAGE&DISKAVAILABLE=$DIKSAVAILABLE&MAILQUEUE=$MAIQUEUE&HOST=$HOST&UPTIME=$UPTIME" https://example.com/resource.cgi



