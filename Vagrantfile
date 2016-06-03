# -*- mode: ruby -*-
# vi: set ft=ruby :

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
  end

  config.vm.define :falcon do |host|
    # Setting hostname isn't working properly with the xenial boxes at the
    # moment.  See below for details:
    # https://bugs.launchpad.net/ubuntu/+source/livecd-rootfs/+bug/1561250
    #host.vm.hostname = 'falcon'
  end
end
