# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"
DOMAIN = "example.dev"
IP = "192.168.56.201"
MEMORY = "512"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
	config.vm.box = "precise32"
	config.vm.box_url = "http://files.vagrantup.com/precise32.box"

	config.vm.hostname = DOMAIN

	config.vm.network :private_network, ip: IP

	config.vm.synced_folder "./www", "/var/www"

	config.vm.provider :virtualbox do |vb|
		vb.name = DOMAIN
		vb.memory = MEMORY
	end

	config.vm.provision :puppet do |puppet|
		puppet.manifests_path = ["vm", "/vagrant/puppet/manifests"]
		puppet.manifest_file = "init.pp"
	end

	config.vm.provision :puppet do |puppet|
		puppet.facter = {
			"domain" => DOMAIN
		}

		puppet.manifests_path = ["vm", "/vagrant/puppet/manifests"]
		puppet.manifest_file = "application.pp"
	end
end