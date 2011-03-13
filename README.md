# monitaur-client

Client for the Monitaur monitoring service

## TODO

Braindump of how I plan to get data from the node to the server:

* Run a script that compiles the data into a Ruby hash


## Installation

The client is installed via rubygems

    gem install monitaur
    
This creates the executable `monitaur`. On the first run, `monitaur` checks for the existence of:

    /var/log/monitaur.log
    /etc/monitaur
    /var/cache/monitaur/plugins
    
## Plugins

I'm still thinking about the best way to handle plugins. I see two approaches:

* Have default plugins reside on the server; custom plugins will be searched for in /etc/monitaur/plugins
* Have all plugins reside server-side; all plugins will be cached inside /var/cache/monitaur/plugins


## Client run

The proposed workflow of a client run:

1) The client is execute via a cron:

    * * * * * monitaur <agent key>
2) the client searches the plugin 



## Data example

Every plugin spits out an array of hashes that look like this:
    
    [
      {
        :key    => :one_minute,
        :value  => "1.05",
        :node   => "71140ea02837012e15ee0025bcdd0280",
        :metric => "load-average"
      },           
      {            
        :key    => :five_minutes,
        :value  => "1.28",
        :node   => "71140ea02837012e15ee0025bcdd0280",
        :metric => "load-average"
      },           
      {            
        :key    => :fifteen_minutes,
        :value  => "1.28",
        :node   => "71140ea02837012e15ee0025bcdd0280",
        :metric => "load-average"
      }
    ]

For each item in the array, a call is made to the Monitaur API that looks like this:

    {
      :data_point => {
        :key => "key",
        :value => "value",
        :metric => "key",
        :node => "uuid"
      }
    }


Load average:

    {
      :data_point => {
        :key => "One Minute",
        :value => "1.01",
        :metric => "load-average",
        :node => "71140ea02837012e15ee0025bcdd0280"
      }
    }


## Copyright

Copyright (c) 2011 Dan Ryan. See LICENSE.txt for
further details.

