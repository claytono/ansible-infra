# -*- mode: ruby -*-
# vi: set ft=ruby :


Vagrant.require_version ">= 1.8.4"
# Vagrant 1.8.4 or higher is needed to work around the following bug
# https://bugs.launchpad.net/ubuntu/+source/livecd-rootfs/+bug/1561250

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/xenial64"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "512"
  end

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "site.yaml"
    ansible.force_remote_user = true
    ansible.extra_vars = {
      :setup_upgrade => true,
    }
    ansible.raw_arguments = [
      '--become',
    ]
    ansible.groups = {
      'docker' => ['falcon'],
    }
  end

  config.vm.define :falcon do |host|
    host.vm.hostname = 'falcon'
  end
end
