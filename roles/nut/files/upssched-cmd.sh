#!/bin/sh

UPSNAME="${2:-${UPSNAME:-ups1}}"

case $1 in
  onbatt_timer)
    /etc/nut/notify-email.sh ONBATT "$UPSNAME"
    ;;
  online_timer)
    /etc/nut/notify-email.sh ONLINE "$UPSNAME"
    ;;
  lowbatt_timer)
    /etc/nut/notify-email.sh LOWBATT "$UPSNAME"
    ;;
  fsd_timer)
    /etc/nut/notify-email.sh FSD "$UPSNAME"
    ;;
  commbad_timer)
    /etc/nut/notify-email.sh COMMBAD "$UPSNAME"
    ;;
  commok_timer)
    /etc/nut/notify-email.sh COMMOK "$UPSNAME"
    ;;
  replbatt_timer)
    /etc/nut/notify-email.sh REPLBATT "$UPSNAME"
    ;;
  nocomm_timer)
    /etc/nut/notify-email.sh NOCOMM "$UPSNAME"
    ;;
  shutdown_timer)
    /etc/nut/notify-email.sh SHUTDOWN "$UPSNAME"
    ;;
  *)
    echo "Unrecognized command: $1" >> /var/log/ups.log
    ;;
esac
