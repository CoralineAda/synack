synack
======

Synack is a client/server wrapper for https://github.com/alloy/terminal-notifier that allows
arbitrary messages to be sent to Mac OS X Mountain Lion's Notification Center.

Note that Terminal Notifier must be installed in your Applications directory for Synack to work
properly.

To send a message to your local Notification Center, you can leave off the host and port (-h and -p)
configuration options:

  synack-client "Watson, come here, I need you."

You can send messages to remote machines by specifying a host and port in the client:

  synack-client -h my_remote_machine -p 11113 "I'm here, what did you want?"

