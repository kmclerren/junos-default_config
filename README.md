# junos-default_config 

## Description

This playbook is used to provision factory new network devices.

## Prerequisites

* ansible: `pip install ansible`
* jxmlease: `pip install jxmlease`
* junos-eznc: `pip install junos-eznc`

## Usage

At a high level, creating a new site in Ansible is broken down into the following steps: Allocating the new site, adding the new site's inventory, creating the new sites host_vars, and finally creating the device configurations. Follow the following steps in order to do so.

**Step 1:** Change to Ansible directory:

```
ansible@xxxxx:~$ cd junos-default_config/
ansible@xxxxx:~/junos-default_config$
```

**Step 2:** Run the script to generate a new site, and answer the questions:

```
ansible@xxxxx:~/junos-default_config$ ./make_new_site.sh
Already up to date.
Enter site name:
rs1
Enter site ipv4 prefix without cidr:
10.222.0.0
Enter site ipv6 prefix without cidr:
2620:123:666::
Enter site ASN:
65536
Creating directory structure for rs1
...Done.
```

**Step 3:** Define your inventory for the new site. Edit the site inventory, adding the new inventory into the defined section:

```
ansible@xxxxx:~/junos-default_config$ cd inventory/
ansible@xxxxx:~/junos-default_config/inventory/rs1$ nano rs1.yml
```

**Step 4:** Generate the host_vars for your newly added inventory:

```
ansible@xxxxx:~/junos-default_config$ ./make_new_site_vars.sh
Enter site name:
rs1
```

**Step 5:** Define the vars for the edge firewalls, or edit any other required vars:

```
ansible@xxxxx:~/junos-default_config$ cd host_vars/
ansible@xxxxx:~/junos-default_config/host_vars$ nano rs1-net-efw-01a.yml
ansible@xxxxx:~/junos-default_config/host_vars$ cd ..
```

**Step 6:** Build the full site configuration:

```
ansible@xxxxx:~/junos-default_config$ ./make.sh
Already up to date.
Already up to date.
Enter site name:
rs1
ansible-playbook 2.9.2
  config file = /home/ansible/junos-default_config/ansible.cfg
  configured module search path = [u'/home/ansible/.ansible/plugins/modules', u'/usr/share/ansible/plugins/modules']
  ansible python module location = /home/ansible/.local/lib/python2.7/site-packages/ansible
  executable location = /home/ansible/.local/bin/ansible-playbook
  python version = 2.7.15+ (default, Oct  7 2019, 17:39:04) [GCC 7.4.0]
Vault password:
<ansible runs>
```

**Step 7:** The build is complete, and the full configurations and host file is avalaible to you, located at: http://1.2.3.4/configs/

**Step 8:** Upgrade SRX to recommended code:

```
Amnesiac (ttyd0)
login: root

--- JUNOS 15.1X49-D150.2 built 2018-09-19 18:09:04 UTC

root> configure
Entering configuration mode

[edit]
root# delete interfaces fxp0

root# set interfaces fxp0 unit 0 family inet dhcp-client

[edit]
root# commit
commit complete

[edit]
root# exit
Exiting configuration mode

root> request system software add no-validate no-copy reboot http://1.2.3.4/ztp/junos-srxmr-15.1X49-D190.2-domestic.tgz

/var/tmp/incoming-package.23235                        681 MB   11 MBps
Package contains junos-srxmr-15.1X49-D190.2-domestic-signed.tgz ; renaming ...
Installing package '/var/tmp/junos-srxmr-15.1X49-D190.2-domestic-signed.tgz' ...
```

**Step 8:** Enable SRX Chassis Clustering:

```
Amnesiac (ttyd0)
login: root

--- JUNOS 15.1X49-D170.4 built 2019-02-22 23:02:01 UTC
root@% cli

root> set chassis cluster cluster-id 1 node 0 reboot

Successfully enabled chassis cluster. Going to reboot now.
```

**Step 9:** Provision any EX4600 stacking ports, they all use the same port numbers:

```
Amnesiac (ttyd0)

login: admin
Password:

--- JUNOS 18.1R3-S6.1 built 2019-06-07 11:51:49 UTC
{master:0}

admin> request virtual-chassis vc-port set pic-slot 0 port 27
Port conversion initiated,  use show virtual-chassis vc-port to verify

{master:0}
admin> request virtual-chassis vc-port set pic-slot 0 port 26
Port conversion initiated,  use show virtual-chassis vc-port to verify
```

**Step 10:** Finally, install the configuration on all devices. This can be done through copy and paste, usb stick, or over the network when the device are factory.