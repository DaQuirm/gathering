# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  config.vm.share_folder "v-root", "/gathering", "."
  config.vm.forward_port 3000, 8081, auto_correct: false

  config.vm.provision "shell", path: "provision.sh"

  config.vm.host_name = "gathering"
end
