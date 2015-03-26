# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "ubuntu/trusty64"

  config.vm.hostname = "subbly-sdk"

  if Vagrant.has_plugin?('vagrant-hostsupdater')
    config.hostsupdater.aliases = [
      "subbly-shop.dev",
      "www.subbly-shop.dev",
    ]
  end

  config.vm.synced_folder "./etc/sites-enabled/", "/etc/nginx/sites-enabled/", type: 'nfs'
  config.vm.synced_folder "./apps/subbly-shop/", "/var/www/subbly-shop.dev/", type: 'nfs'

  config.vm.network 'private_network', ip: "192.168.57.111"

  config.vm.provision :shell, path: "./scripts/install.sh", run: "once"
  config.vm.provision :shell, path: "./scripts/start.sh", run: "always"

  config.vm.provider :virtualbox do |virtualbox|
    virtualbox.customize ['modifyvm', :id, "--natdnshostresolver1", "on"]
    virtualbox.customize ['modifyvm', :id, '--memory', "1024"]
    virtualbox.customize ['modifyvm', :id, '--cpus', "1"]
    virtualbox.customize ['modifyvm', :id, '--name', config.vm.hostname]
  end
end
