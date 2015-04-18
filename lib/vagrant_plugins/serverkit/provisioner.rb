require "logger"
require "serverkit"
require "vagrant"

module VagrantPlugins
  module Serverkit
    class Provisioner < Vagrant.plugin("2", :provisioner)
      def provision
        ::Serverkit::Actions::Apply.new(
          hosts: host,
          log_level: log_level,
          recipe_path: config.recipe_path,
          ssh_options: ssh_options,
          variables_path: config.variables_path,
        ).call
      rescue => exception
        raise ServerkitError, exception
      end

      private

      # @return [true, nil]
      def forward_agent
        if machine.ssh_info[:forward_agent]
          true
        end
      end

      # @return [String] Host name of the provisioned machine
      def host
        machine.ssh_info[:host]
      end

      # @return [Fixnum]
      def log_level
        ::Serverkit::Command::LOG_LEVELS_TABLE[config.log_level] || ::Logger::UNKNOWN
      end

      # @return [Fixnum, nil]
      def port
        if machine.ssh_info[:port]
          machine.ssh_info[:port].to_i
        end
      end

      # @return [Net::SSH::Proxy::Command, nil]
      def proxy
        if machine.ssh_info[:proxy_command] && machine.ssh_info[:proxy_command] != "none"
          require "net/ssh/proxy/command"
          Net::SSH::Proxy::Command.new(machine.ssh_info[:proxy_command])
        end
      end

      # @return [Hash<Symbol => Object>] SSH options for Net::SSH.start
      def ssh_options
        {
          forward_agent: forward_agent,
          keys_only: true,
          keys: machine.ssh_info[:private_key_path],
          port: port,
          proxy: proxy,
          user: machine.ssh_info[:username],
          user_known_hosts_file: "/dev/null",
          verbose: :fatal,
        }.reject do |key, value|
          value.nil?
        end
      end

      class ServerkitError < Vagrant::Errors::VagrantError
        # @note Override
        def initialize(original_exception)
          @original_exception = original_exception
          super()
        end

        # @note Override
        def error_message
          @original_exception.to_s
        end
      end
    end
  end
end
