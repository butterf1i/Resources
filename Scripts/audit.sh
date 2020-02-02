#!/bin/sh
# security audit for ccdc linux servers

cd ~

# check for stray ssh keys
if [ test -f /etc/ssh/sshd_config ]
then
	AuthKeys=$(fgrep -m 1 AuthorizedKeysFile /etc/ssh/sshd_config)
	if [ ${AuthKeys:0:1} != "#" ]
	then
		echo -n "Warning: non-standard SSH key location. Keys are in "
		echo $AuthKeys
		KeyLocation=$(echo `expr match AuthKeys '.*\s\(.*\/.*\).*'`)
	else
		KeyLocation=".ssh/authorized_keys"
	fi
fi

if [ test -f "$KeyLocation" ]
then
	echo "Warning: SSH key file exists."
fi
