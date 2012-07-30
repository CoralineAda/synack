synack
======

Synack is a client/server wrapper for https://github.com/alloy/terminal-notifier that allows
arbitrary messages to be sent to Mac OS X Mountain Lion's Notification Center.

Note that Terminal Notifier must be installed in your Applications directory for Synack to work
properly.

To start synack:

    synack -s

To send a message to your local Notification Center:

    synack "Watson, come here, I need you."

You can send messages to remote machines by specifying a host and port in the client:

    synack -h my_remote_machine -p 1013 "I'm here, what did you want?"

You can use UNIX pipes to send messages (first line of input only, for now):

    echo 'Foo to you, sir.' | synack

You can even invoke it from within a Ruby or Rails application:

    def log_remote_event(event_name)
      Synack::Client.new(:host => '10.0.1.1').say("Event #{event_name} captured")
    end
