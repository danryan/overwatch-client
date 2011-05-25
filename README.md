# overwatch-client

Client for the Overwatch monitoring service

## Installation

The client is installed via rubygems

    gem install overwatch
    
This creates the executable `overwatch`. Currently there is no daemon, so you can run it as a cron job:

    * * * * * overwatch <api key>
    
## Plugins

Plugins are stored client-side for ease of deployment by your configuration management service. See the Plugin wiki for more info.

## Client run

* Client compiles the plugins and executes each, storing the result of each into a hash
* Client sends the resultant hash to the server for processing.
* That's it!

## Copyright

Copyright (c) 2011 Dan Ryan. See LICENSE.txt for
further details.

