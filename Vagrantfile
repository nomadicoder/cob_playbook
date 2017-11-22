# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

# Set the application name
APP_NAME = "xb70"
SRC_NAME = "xb70"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "centos/7"
  config.vm.hostname = APP_NAME
  config.vm.network "forwarded_port", guest: 5100, host: 5100
  config.vm.network "forwarded_port", guest: 3000, host: 3000
  config.vm.network "forwarded_port", guest: 8983, host: 8983
  #config.vm.network "forwarded_port", guest: 8985, host: 8985
  #config.vm.network :forwarded_port, guest: 4000, host: 4000

  config.vm.synced_folder "../xb70", "/var/www/#{APP_NAME}"
  config.vm.synced_folder ".", "/vagrant", disabled: true

  #config.vm.network "private_network", ip: "192.168.33.11"

  config.vm.provider "virtualbox" do |v|
    host = RbConfig::CONFIG['host_os']

    # Give VM 1/4 system memory
    if host =~ /darwin/
      # sysctl returns Bytes and we need to convert to MB
      mem = `sysctl -n hw.memsize`.to_i / 1024
    elsif host =~ /linux/
      # meminfo shows KB and we need to convert to MB
      mem = `grep 'MemTotal' /proc/meminfo | sed -e 's/MemTotal://' -e 's/ kB//'`.to_i
    elsif host =~ /mswin|mingw|cygwin/
      # Windows code via https://github.com/rdsubhas/vagrant-faster
      mem = `wmic computersystem Get TotalPhysicalMemory`.split[1].to_i / 1024
    end

    mem = mem / 1024 / 4
    mem = 2048 if mem > 2048

    v.customize ["modifyvm", :id, "--memory", mem]
  end

  config.vm.provision "ansible" do |ansible|
      ansible.playbook = "playbook.yml"
      ansible.sudo = true
      ansible.host_key_checking = false
      # ansible.verbose =  'vvvv'
      ansible.limit = 'all'
      ansible.inventory_path = 'inventory/vagrant/'
      ansible.extra_vars = { ansible_ssh_user: 'vagrant',
          ansible_connection: 'ssh',
          ansible_ssh_args: '-o ForwardAgent=yes'}
  end
end
