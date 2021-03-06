# vagrant-serverkit
[Vagrant](https://github.com/mitchellh/vagrant) plug-in for [Serverkit](https://github.com/r7kamura/serverkit).

- [Usage](#usage)
  - [Install](#install)
  - [Config](#config)
  - [Example](#example)
- [Development](#development)

## Usage
### Install
```
$ vagrant plugin install vagrant-serverkit
```

### Config
The following configurations are available on serverkit provisioner:

- `recipe_path` - Path to serverkit recipe (e.g. `"recipe.yml"`)
- `variables_path` - Path to serverkit recipe variables (e.g. `"variables.yml"`, optional)
- `log_level` - Log level (e.g. `"DEBUG"`, optional)

### Example
Here is an example to provision a vagrant box with Serverkit.

```rb
# Vagrantfile
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.provision(
    :serverkit
    recipe_path: "recipe.yml.erb",
    variables_path: "variables.yml",
  )
end
```

```erb
# recipe.yml.erb
resources:
  <%- package_names.each do |package_name| -%>
  - type: package
    name: <%= package_name %>
  <%- end -%>
```

```yaml
# variables.yml
package_names:
  - curl
  - nginx
```

```
$ vagrant up
```

### Plugin
If you want to use external serverkit plugins like
[serverkit-rbenv](https://github.com/r7kamura/serverkit-rbenv),
install them as vagrant plugin like `vagrant plugin install serverkit-rbenv`.
[vagrant-multiplug](https://github.com/r7kamura/vagrant-multiplug) might help you
use so many plugins.
