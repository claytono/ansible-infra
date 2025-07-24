
# ansible-wifi [![Build Status](https://travis-ci.org/layereight/ansible-wifi.svg?branch=master)](https://travis-ci.org/layereight/ansible-wifi)

A simple Ansible role to install and configure wpa_supplicant on Debian like systems.

## Requirements

* a user with sudo permissions

## Install the role via Ansible Galaxy

Typical run:
```sh
$ ansible-galaxy install layereight.wifi
```

If you want to install a specific version in a collection with other roles using a role file:
```sh
$ ansible-galaxy install -r roles.yml
```
*roles.yml*
```YAML
- name: layereight.wifi
  src: layereight.wifi
  version: "1.3.0"
```
* also see the [Ansible Galaxy documentation](http://docs.ansible.com/ansible/galaxy.html) and the 
[Ansible Galaxy introduction](https://galaxy.ansible.com/intro)

## Role Variables

### mandatory

* **wifi_ssid:** Your Wifi's SSID.

* **wifi_psk:** Your Wifi's password.

### optional

* **wifi_country**
  * default: "DE"
  * description: [Country code](https://w1.fi/cgit/hostap/tree/wpa_supplicant/wpa_supplicant.conf#n206) for the country in which
    the wifi device is currently operating.
  
* **wifi_control_interface_access_group**
  * default: root
  * description: Potentially used to allow non-root users to use the control interface.
    [see wpa_supplicant for more information](https://w1.fi/cgit/hostap/tree/wpa_supplicant/wpa_supplicant.conf#n44)

* **wifi_apt_cache_valid_time**
  * default: 86400
  * description: Number of seconds APT cache is valid for.

* **wifi_rfkill_unblock**
  * default: true
  * description: Unblock wifi interface using `rfkill` when set to `true`.

* **wifi_disable_dhcpcd_workaround**
  * default: false
  * description: dhcpcd interferes with normal interfaces config for wpa_supplicant. This workaround will disable dhcpcd
    for the given **wifi_disable_dhcpcd_workaround_interface** as well as the wpa_supplicant hook.

* **wifi_disable_dhcpcd_workaround_interface**
  * default: wlan0
  * description: The network interface we will apply the **wifi_disable_dhcpcd_workaround** for.

## Example Playbook

Typical playbook run:
```sh
$ ansible-playbook -i inventory wifi.yml
```

*inventory*
```INI
[wifihosts]
myhost ansible_host=192.168.0.101 ansible_user=myuser ansible_ssh_pass=password 
```

*wifi.yml*
```YAML
- hosts: wifihosts
  
  roles:
    - layereight.wifi
  
  vars:
    wifi_ssid: "my_wifi_name"
    wifi_psk: "my_wifi_password"
```
