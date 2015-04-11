require "vagrant"

module VagrantPlugins
  module Serverkit
    class Plugin < Vagrant.plugin("2")
      name "serverkit"

      config(:serverkit, :provisioner) do
        require_relative "config"
        Config
      end

      provisioner(:serverkit) do
        require_relative "provisioner"
        Provisioner
      end
    end
  end
end
