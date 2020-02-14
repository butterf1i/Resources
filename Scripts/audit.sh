#!/bin/bash
# security audit for ccdc linux servers

cd ~

# check for stray ssh keys
echo "SSH:"
echo "===="
if test -f /etc/ssh/sshd_config
then
	AuthKeys=$(fgrep -m 1 AuthorizedKeysFile /etc/ssh/sshd_config)
	if [ ${AuthKeys:0:1} != "#" ]
	then
		KeyLocation=$(echo `expr match AuthKeys '.*\s\(.*\/.*\).*'`)
		echo -n "WARNING: non-standard SSH key location. Keys are in"
		echo $KeyLocation
	else
		KeyLocation=".ssh/authorized_keys"
	fi
fi

if test -f "$KeyLocation"
then
	echo -n  "WARNING: found SSH key file: "
	echo $KeyLocation
fi


echo ""
echo ""


# check firewall rules
InputRules=$(iptables -L INPUT)
ForwardRules=$(iptables -L FORWARD)
OutputRules=$(iptables -L OUTPUT)
echo "FIREWALL RULES:"
echo "==============="
echo "$InputRules"
echo "$ForwardRules"
echo "$OutputRules"


