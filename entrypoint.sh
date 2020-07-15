#!/bin/bash
if [ ! -f /www/bookstack/dbupdated ]
then
  /www/bookstack/BookStack install 2>&1 | tee /www/bookstack/dbupdated
else
  echo "###db had updated,skip bookstack install,just start it!###"
fi
/www/bookstack/BookStack
