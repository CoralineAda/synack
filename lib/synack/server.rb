require 'drb'
require 'socket'

module Synack

  class Server

    DEFAULT_OPTIONS = {
      host: 'localhost',
      port: 11113
    }

    attr_reader :host, :port, :socket

    # Class methods ================================================================================

    def self.start(options={})
      options = DEFAULT_OPTIONS.merge(options)
      @host = options[:host]
      @port = options[:port].to_i
      @@server = Synack::Server.new
      puts "Synack server running. Fire at will."
      ::DRb.start_service("druby://#{@host}:#{@port}", @@server)
      ::DRb.thread.join
    end

    def self.stop
      ::DRb.stop_service
    end

    # Instance methods =============================================================================

    def sanitize(message)
      message && message.gsub(/[^0-9A-z\.\-\'\, ]/, '_')
    end

    def say(message)
      
      terminal_notifier_path = `which terminal-notifier`
      unless terminal_notifier_path == 'terminal-notifier not found'
        puts message
        system "#{terminal_notifier_path} -message \"#{sanitize(message)}\""
      else
        puts "You don't have terminal-notifier installed, please install it."
      end
    end

  end

end
