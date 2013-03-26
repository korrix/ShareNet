ShareNet by Korri
=================
To know what exactly this script does - read the source :D
(It is all about sharing aero2 GSM connection via WiFi)

DEPENDENCIES
------------
* ruby (2.0 compatible)
* isp-dhcp-server
* colorize gem
* iptables
* hostapd

OTHER INFO
----------
* Make sure that your wireless card supports Master mode
* Remember to stop NetworkManager!
* Special notes for ubuntu users:
  * Configure apparmor to permit dhcpd to read local configuration files (by editing `/etc/apparmor.d/usr.sbin.dhcpd` file)
  * Disable ufw firewall (`ufw disable`)

LICENSE
-------
Copyright (C) 20013 Korri

This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program; if not, write to the Free Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
