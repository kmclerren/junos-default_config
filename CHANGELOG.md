# Changelog

## 02/03/20

* All: Add new var: site_system.dhcp_server. Reference this for site DHCP servers, rather than auto generated
* ICR: Change wireless DHCP to look at site_system.dhcp_server
* ICR: Update DHCP server to look at site_system.dhcp_server
* UTS: Update wireless to reflect splitting between two members
* UTS: Uplinks updated to correct FPX members for two-member stack
* OBR: Update DHCP server to look at site_system.dhcp_server.
* IDR: Missing vlans 2100 and 2008 to UTS uplinks
* SNMP: Add local 2253 subnet to SNMP ACL, auto generated based off site subnet


Older

## [all]

* Broke out roles into individual repos for CI and use of requirements and sharing of roles
* Added requirements.yml to pull in roles
* Updated role names for shared roles with 'junos-' prefix
* Added /etc/hosts file generation template
* Virtual chassis no longer use pre-provision. This is done to do away with need for serial numbers, as well as addres a failure scenario
* Inventory has been updated to query Netbox, and the inventory structure has been updated
* added push config to push device configurations over opengear
* inventory format has been simplified
* roles have been entirely overhauled
* group_vars and host_vars now use subdirectories for future var break out
* file extensions are .yml now
* jumbo frames enabled across all devices by default
* use of groups has been limited to edge devices only
* vlan tag named have been shortened to v[$tag]
* routers now set the last octet of the following off the last octet of the management IP: vlan 200, lo0, router-id, pim rp address
* z-wireless ACL has been simplified and unified across any site, with only local DNS servers changing

## [icr]

* Added system dns servers and domain name
* Added dia_uplink_type host var to select ge or xe for uplink to DIA
* Disable spanning tree on DIA uplink ports
* added wireless ACL
* sflow has been preconfigured
* uplink ports are now hard set (idr, vpn, efw, etc)
* additional future expansion idr uplinks have been pre-designated
* vstp configuration has been simpilifed by using vlan groups: root, and non-root
* vstp configuration now includes "interface all"

## [idr]

* uplink ports are now hard set
* sflow has been preconfigured
* additional future expansion uplinks for multi use have been pre-designated
* vstp configuration has been simpilifed by using vlan groups: root, and non-root
* vstp configuration now includes "interface all"

## [dat]

* move from groups to interface-ranges for user ports
* change all vstp related items to use interface-range
* change max-mac-limit action to shutdown, and moved under switch-options instead of per vlan
* added better interface descriptions
* added recovery-timeout for port security options and set to 30 minutes
* added dat specific syslog config to help filter log messages to things we care about
* change bpdublock timer to 30 minutes to match port security recovery timer
* added custom logs: updown, port-security, and ndi to trim down messsages file

## [uts]

* move from groups to interface-ranges
* all interfaces now properly configured as edge ports
* added "wap_trunks" true/false var to configure wap uplinks as trunk or access

## [s01]

* remove groups
* add 5 pre-configured lags
* remove any pre-configured uplinks, except trunk to icr
* pre-configure server lags as edge trunk ports with bpduguard
* add 200 count mac limit to server lags
* added recovery-timeout to server lag interfaces set to 30 minutes for exceeding mac count

## [obr]

* EX4600 17.x doesnt have our special mac-shift, so change management related items to use irb.2253, sourcing from lo0 and routing-options config

## [efw]

* This is a new combined vpn/efw role. Everything is new.
* Added LLDP support
* LAB ONLY: proxy-arp config. Work arounds due to limitations of lab.
