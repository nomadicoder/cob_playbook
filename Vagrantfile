# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

# Set the application name
APP_NAME = "tulcob"
SRC_NAME = "tulcob"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "centos/7"
  config.vm.hostname = APP_NAME
  config.vm.network "forwarded_port", guest: 5100, host:5100
  config.vm.network "forwarded_port", guest: 3000, host: 3000
  config.vm.network "forwarded_port", guest: 8983, host: 8983
  #config.vm.network "forwarded_port", guest: 8985, host: 8985
  #config.vm.network :forwarded_port, guest: 4000, host: 4000

  config.vm.synced_folder "../tul_cob", "/var/www/#{APP_NAME}_dev"
  config.vm.synced_folder ".", "/vagrant", disabled: true

  #config.vm.network "private_network", ip: "192.168.33.11"

  config.vm.provider "virtualbox" do |v|
    v.memory = 4096
    v.cpus = 2
  end

  config.vm.provision "ansible" do |ansible|
      ansible.playbook = "playbook.yml"
      ansible.sudo = true
      ansible.host_key_checking = false
      ansible.limit = 'all'
      ansible.inventory_path = 'inventory/vagrant/'
      # ansible.verbose =  'vvvv'
      ansible.extra_vars = { ansible_ssh_user: 'vagrant',
          ansible_connection: 'ssh',
          ansible_ssh_args: '-o ForwardAgent=yes'}
  end
end
