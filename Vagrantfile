Vagrant.require_plugin("vagrant-serverkit")

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.provision :serverkit do |serverkit_config|
    serverkit_config.recipe_path = "recipe.yml.erb"
    serverkit_config.variables_path = "variables.yml"
  end
end
