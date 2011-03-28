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

Plugins are stored server-side. Clients first connect to the server to retrieve a manifest of plugins it should have. This manifest includes a list of plugins and their checksums. If a plugin's checksum hasn't changed, no action is taken. If a plugin's checksum has changed, the client downloads and caches the new plugin.

## Client run

* Client checks with the server to see if it has new plugins
* Client downloads new plugin data if necessary
* Client loads all plugins
* Client processes each plugin
* Client returns results of plugin runs to server

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

