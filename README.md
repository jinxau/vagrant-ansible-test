vagrant-ansible-test
====================

The intention here is to make some of my ansible tests available for people to go through.

If you're just starting with ansible and/or vagrant, it's suggested that you check out the following sites to get you up and running.

  * Ansible documentation for vagrant - http://docs.ansible.com/guide_vagrant.html
  * Download and install vagrant - http://vagrantup.com
  
Note to adjust box source.
============

The boxes used in this example are generated with packer (http://packer.io).

You will need to replace the config.vm.box and config.vm.box_url (may also have to uncomment it) in the Vagrantfile with a box that is available on the internet:
- https://github.com/2creatives/vagrant-centos/releases/download/v0.1.0/centos64-x86_64-20131030.box

In the above case our Vagrantfile should have the following entries:
>    config.vm.box = "centos64-x86_64-20131030"

>    config.vm.box_url = "https://github.com/2creatives/vagrant-centos/releases/download/v0.1.0/centos64-x86_64-20131030.box"

More boxes available at http://www.vagrantbox.es/

