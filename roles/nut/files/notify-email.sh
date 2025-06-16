#!/bin/bash
# NUT notify-email.sh: Send email on NUT events
# Called by upsmon via NOTIFYCMD

EMAIL="{{ nut_notify_email | default('root@localhost') }}"
HOSTNAME=$(hostname)
EVENT="$1"

# Compose subject and body
SUBJECT="[NUT] Power event on $HOSTNAME: $EVENT"
BODY="NUT event: $EVENT\n\nDetails:\nUPS: $UPSNAME\nDate: $(date)\n"

# Add more details if available
if [ -n "$NOTIFYTYPE" ]; then
  BODY+="Type: $NOTIFYTYPE\n"
fi
if [ -n "$NOTIFYMSG" ]; then
  BODY+="Message: $NOTIFYMSG\n"
fi

# Send the email using sendmail
cat <<EOF | /usr/sbin/sendmail -t
To: $EMAIL
Subject: $SUBJECT

$BODY
EOF
