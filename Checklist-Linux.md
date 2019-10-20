# Cleaning linux boxes

## Initial Setup
### SSH
* /etc/ssh/sshd_config
  * disable root login
  * verify that there isn't a rule that allows all users to SSH
  * check SSH key locations
* delete any keys that aren't yours

### Users
* /etc/shadow
  * look for users without a password
* /etc/sudoers
  * look for sudo privileges that shouldn't be there
  * verify that no one can use sudo without a password

## After Initial Setup
**FIRST:** kill any active red team SSH sessions:
* do 'who -u', then for any sessions that shouldn't be there, do 'kill [process #]'

### Log Files
* open a new terminal and do 'tail -f /var/log/auth.log', check periodically for suspicious logins

### Firewall
depends on the scenario - block anything that isn't scored traffic or your own ssh traffic

### Suspicious Files
Check the following for out-of-place files:
* cron jobs
* /root
* /home/... for all users
* /etc/systemd/init
* /etc/rc.local

### Other tasks
* generate your own SSH keys
