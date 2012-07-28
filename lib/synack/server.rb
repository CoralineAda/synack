module Synack

  class Server

    attr_accessor :host, :port, :socket

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
      self.host   = args[:host] || 'localhost'
      self.port   = args[:port] || 131313
      self.socket = TCPSocket.open(host, port)
    end

    # FIXME scrub msg to avoid execution of arbitrary commands
    def send(message)
      system "/Applications/terminal-notifier.app/Contents/MacOS/terminal-notifier --message message"
    end

  end

end
