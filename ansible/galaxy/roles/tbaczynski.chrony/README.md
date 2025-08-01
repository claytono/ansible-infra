Role Name
=========

Install and setup `chrony` NTP daemon

Platforms
---------

This role was created and tested for Ubuntu Bionic only.

Requirements
------------


Role Variables
--------------

- `ntp_servers`: list of ntp servers (fqdn's)
- `ntp_pool`: pool of ntp servers , used when ntp_servers is empty
- `ntp_auth`: (boolean) enable ntp authentication, symetric keys
- `ntp_keys`: list of keys for ntp_auth
- `ntp_key_refernce`: key.id for clients

When authentication is enabled, client has only `ntp_key_refernce` in the `chrony.keys` file. Server (`ansible_fqdn` are in `ntp_servers` list) has all defined keys.

Dependencies
------------


Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - chrony

Additional Info
---------------

https://bugs.launchpad.net/ubuntu/+source/chrony/+bug/1744072


License
-------

BSD

Author Information
------------------

Tomasz Baczynski
