# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  config.vm.box       = 'precise64'
  config.vm.box_url   = 'http://files.vagrantup.com/precise64.box'
  config.vm.host_name = 'precise64'

  config.vm.network :forwarded_port, guest: 3000, host: 3000

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = ["chef/cookbooks", "chef/site-cookbooks"]
    chef.roles_path     = [[:host, "chef/roles"]]
    chef.data_bags_path = [[:host, "chef/data_bags"]]

    chef.add_role "rails-development"
    chef.json = {
        "postgresql" => {
          "password" => {
            "postgres" => ""
          }
        },
        "rbenv" => {
          "global"  => "2.0.0-p247",
          "rubies" => [ "2.0.0-p247" ],
          "gems" => {
            "2.0.0-p247" => [
              { 'name' => 'bundler' }
            ]
          }
        }
      }
  end
end
