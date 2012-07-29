require 'drb'
require 'socket'

module Synack

  class Client

    DEFAULT_OPTIONS = {
      host: '0.0.0.0',
      port: 11113
    }
    
    attr_reader :host, :port, :socket
    
    # Instance methods =============================================================================
    
    def initialize(options = {})
      options = DEFAULT_OPTIONS.merge(options)

      @host = options[:host]
      @port = options[:port]

      @socket = DRbObject.new(nil, "druby://#{@host}:#{@port}")
    end
    
    def send(message)
      @socket.send(message)
    end
  end
end
