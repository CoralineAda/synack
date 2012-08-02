require 'drb'
require 'socket'

module Synack

  class Server

    DEFAULT_OPTIONS = {
      host: 'localhost',
      port: 11113,
    }

    attr_reader :host, :port, :socket

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

    def binary
      binary = '/Applications/terminal-notifier.app/Contents/MacOS/terminal-notifier'
      unless File.exists? binary
        binary = `which "terminal-notifier"`
        binary.chomp!
        raise "terminal-notifier could not be found in path" unless $? == 0
      end
      binary
    end

    def sanitize(message)
      message && message.gsub(/[^0-9A-z\.\-\'\, ]/, '_')
    end

    def say(message)
      puts message
      STDERR.puts command = "#{self.binary} -message \"#{sanitize(message)}\""
      system command
    end

  end

end
