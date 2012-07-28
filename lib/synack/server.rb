module Synack

  class Server

    attr_reader :host, :port, :socket

    # Class methods ================================================================================

    def self.start(args={})
      @@server = Synack::Server.new(args)
      DRb.start_service("druby://#{@@server.host}:#{@@server.port}", @@server)
      DRb.thread.join
    end

    def self.stop
      DRb.stop_service
    end

    # Instance methods =============================================================================

    def initialize(args={})
      @host   = args[:host] || 'localhost'
      @port   = args[:port] || 131313
      @socket = TCPSocket.open(host, port)
    end

    def sanitize(message)
      message.gsub(/[^0-9A-z\.\-\']/, '_')
    end

    def send(message)
      system "/Applications/terminal-notifier.app/Contents/MacOS/terminal-notifier --message \"#{sanitize(message)}\""
    end

  end

end
