require "vagrant"

module VagrantPlugins
  module Serverkit
    class Config < Vagrant.plugin("2", :config)
      attr_accessor :recipe_path
      attr_accessor :variables_path

      # @note Override to make sure that recipe_path is specified
      def validate(machine)
        errors = _detected_errors
        if recipe_path.nil?
          errors << 'Set recipe_path to config (e.g. "recipe.yml")'
        end
        { "serverkit_provider" => errors }
      end
    end
  end
end
