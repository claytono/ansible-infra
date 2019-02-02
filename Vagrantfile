# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.require_version ">= 1.8.4"
# Vagrant 1.8.4 or higher is needed to work around the following bug
# https://bugs.launchpad.net/ubuntu/+source/livecd-rootfs/+bug/1561250

unless Vagrant.has_plugin?('vagrant-hostmanager')
  raise "Vagrant file requires vagrant-hostmanager plugin to work properly"
end

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/xenial64"

  config.hostmanager.enabled = true
  config.hostmanager.manage_guest = true

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "1024"
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on" ]
  end

  config.vm.provision "ansible" do |ansible|
    ansible.compatibility_mode = '2.0'
    ansible.playbook = "site.yaml"
    ansible.force_remote_user = true
    ansible.extra_vars = {
      :setup_upgrade => true,
      :domain => 'oneill.net',
      :is_vagrant => true,
      :borgbackup_client => false,
    }
    ansible.host_vars = {
      'k1' => { "api_advertise_address" => "172.19.19.10" },
    }
    ansible.raw_arguments = [
      '--become',
    ]
    ansible.groups = {
      'docker' => ['falcon', 'k1', 'k2', 'k3'],
      'kubernetes' => ['k1', 'k2', 'k3'],
      'kubernetes-master' => ['k1'],
      'kubernetes-node' => ['k2', 'k3'],
      'plex-client' => ['plex-client'],
      'plex-server' => ['plex-server'],
    }
  end

  config.vm.define :falcon do |host|
    host.vm.hostname = 'falcon'
  end
  config.vm.define :k1 do |host|
    host.vm.hostname = 'k1.oneill.net'
    host.vm.network "private_network", ip: "172.19.19.10"
    host.hostmanager.aliases = %w(k1)
  end
  config.vm.define :k2 do |host|
    host.vm.hostname = 'k2.oneill.net'
    host.vm.network "private_network", ip: "172.19.19.11"
    host.hostmanager.aliases = %w(k2)
  end
  config.vm.define :k3 do |host|
    host.vm.hostname = 'k3.oneill.net'
    host.vm.network "private_network", ip: "172.19.19.12"
    host.hostmanager.aliases = %w(k3)
  end
  config.vm.define 'plex-server' do |host|
    host.vm.hostname = 'plex-server'
    host.vm.box = "ubuntu/trusty64"
  end
  config.vm.define 'plex-client' do |host|
    host.vm.hostname = 'plex-client'
    host.vm.box = "ubuntu/trusty64"
  end
end
