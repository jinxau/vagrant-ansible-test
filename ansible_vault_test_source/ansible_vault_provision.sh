#!/bin/bash
#
# Used to setup our ansible configuration for testing ansible vault.
#

set -u 
set -x 

# variables
declare -a HOSTS=("192.168.44.32")
GIT_SRC="https://github.com/Kahn/ansible"
GPG_KEY_SRC="/vagrant/data/test_keys.asc"
GPG_KEY_ID="EEB6BE02"
VAGRANT_HOME="/home/vagrant"
ANSIBLE_HOME="$VAGRANT_HOME/ansible"
ANSIBLE_CONFIG="$ANSIBLE_HOME/examples/ansible.cfg"
VAULT_CREATE_SCRIPT="/vagrant/data/vault_create_script.sh"

# import gpg test keys
gpg --import $GPG_KEY_SRC
gpg --allow-secret-key-import --import $GPG_KEY_SRC

# clone our repo
git clone $GIT_SRC

# set our environment variables
PYTHONPATH=""
MANPATH=""

grep "$ANSIBLE_HOME/hacking/env-setup" $VAGRANT_HOME/.bash_profile

# add to bash_profile, but only if it does not exist.
if [ $? -eq 1 ]; then
  echo "source $ANSIBLE_HOME/hacking/env-setup" >> $VAGRANT_HOME/.bash_profile
fi

# setup ansible config
cp $ANSIBLE_CONFIG $VAGRANT_HOME/.ansible.cfg
echo 'cipher = GPG' >> $VAGRANT_HOME/.ansible.cfg
echo 'recipients = $GPG_KEY_ID' >> $VAGRANT_HOME/.ansible.cfg
echo 'gpg_debug = True' >> $VAGRANT_HOME/.ansible.cfg

# setup our hosts
echo "# auto-generated host list" > $ANSIBLE_HOME/hosts
for HOST in "${HOSTS[@]}"
do
   echo "$HOST" >> $ANSIBLE_HOME/hosts
done

# create ansible vault 
echo "# Vault list auto-generated by vagrant." > $VAULT_CREATE_SCRIPT
for VAULT in $(cat $ANSIBLE_HOME/hosts);do
  echo "Creating vault for $VAULT" >> $VAULT_CREATE_SCRIPT
  echo "ansible-vault create host_vars/$VAULT" >> $VAULT_CREATE_SCRIPT
done
