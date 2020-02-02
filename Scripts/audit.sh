#!/bin/bash
# security audit for ccdc linux servers

cd ~

# check for stray ssh keys
if test -f /etc/ssh/sshd_config
then
	AuthKeys=$(fgrep -m 1 AuthorizedKeysFile /etc/ssh/sshd_config)
	if [ ${AuthKeys:0:1} != "#" ]
	then
		KeyLocation=$(echo `expr match AuthKeys '.*\s\(.*\/.*\).*'`)
		echo -n "Warning: non-standard SSH key location. Keys are in"
		echo $KeyLocation
	else
		KeyLocation=".ssh/authorized_keys"
	fi
fi

if test -f "$KeyLocation"
then
	echo -n  "Warning: found SSH key file: "
	echo $KeyLocation
fi
