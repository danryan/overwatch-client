# Installation

  gem install overwatch

# Configuration

Configuration of `overwatch` can be done in one of two ways: command-line options, and a config file in the YAML format. If no config options are specified, the `overwatch` executable will look for a file called `.overwatchrc` in the `HOME_DIR` of the user that is executing the command. Parameters that can be configured in the config file are:

* Server
* Port
* API key

Even if an option is specified in the config file, it can be overridden with a command-line argument. Options ommitted will use the default values.

## Example configuration file

    server: overwatch.example.com
    port: 9090
    key: asdf1234asdf1234asdf1234asdf234
      
# Usage

I'm going to assume you've got overwatch-collection running somewhere on your local machine for the purpose of this documention.
    
## Help!

All commands provide a contextual help menu. Append `--help` to the end of any command or subcommand to bring up its specific help menu.

## Main command

When you install `overwatch` via RubyGems, an executable, `overwatch`, is installed somewhere in your $PATH (the exact location is entirely dependent upon your Ruby/Gems setup).

#### Usage:
    overwatch [OPTIONS] SUBCOMMAND [ARGS] ...

#### Parameters

    SUBCOMMAND                    subcommand name
    [ARGS] ...                    subcommand arguments

#### Subcommands

    run                           Compile and send a new snapshot to the server
    resource                      Resources
    snapshot                      Snapshots
    

#### Options
    -c, --config CONFIG    Overwatch config file
    -k, --key KEY          API key (default: nil)
    -s, --server SERVER    collection server (default: "localhost")
    -p, --port PORT        collection port (default: "9001")
    -f, --format [FORMAT]  format (choices: pretty, json, text) (default: "pretty")


## Subcommands

### overwatch run

#### Usage

    overwatch run [OPTIONS] [ARGS] ...
    
#### Parameters

    SUBCOMMAND                    subcommand name
    [ARGS] ...                    subcommand arguments

### overwatch resource

#### Usage
    
    overwatch resource [OPTIONS] SUBCOMMAND [ARGS] ...

#### Parameters
        
    SUBCOMMAND                    subcommand name
    [ARGS] ...                    subcommand arguments

#### Subcommands

    list                          list all resources
    show                          show a specific resource
    create                        create a new resource
    update                        update an existing resource
    delete                        delete an existing resource
    regenerate                    regenerate a resource's API key

### overwatch resource list

#### Usage
      
    overwatch resource list [OPTIONS]

#### Examples:

Pretty format:

    $ overwatch resource list --format pretty
    +----+------+--------------------------------+
    | id | name | api_key                        |
    +----+------+--------------------------------+
    | 1  | foo  | 3ec97eb0d2870db4b061533812d8a1 |
    | 2  | bar  | e0a5f1baf553f27115cb45ea1ef51a |
    | 3  | baz  | 5273d592d9a7465ed1b3ae820d06a1 |
    +----+------+--------------------------------+
    3 rows in set
        
Plaintext format for easy piping/grepping/awking:

    $ overwatch resource list --format text
    1  foo  3ec97eb0d2870db4b061533812d8a1 
    2  bar  e0a5f1baf553f27115cb45ea1ef51a 
    3  baz  5273d592d9a7465ed1b3ae820d06a1


### overwatch resource show

#### Usage
    
    overwatch resource show [OPTIONS] NAME_OR_ID

#### Parameters

    NAME_OR_ID                    resource name or id

#### Options

    -a, --attributes              list all resource attributes

#### Example

Find a resource by _name_ and display it

    $ overwatch resource show foo
    +----+------+--------------------------------+
    | id | name | api_key                        |
    +----+------+--------------------------------+
    | 1  | foo  | 3ec97eb0d2870db4b061533812d8a1 |
    +----+------+--------------------------------+
    1 row in set

Find a resource by _id_ and display it in plain text:

    $ overwatch resource show --format text 2
    2  bar  e0a5f1baf553f27115cb45ea1ef51a

### overwatch resource delete
  
    raise NotImplementedError, "This will be available in a future release."

### overwatch resource update

    raise NotImplementedError, "This will be available in a future release."
    
### overwatch resource regenerate

    raise NotImplementedError, "This will be available in a future release."

### overwatch snapshot

    raise NotImplementedError, "This will be available in a future release."



## TODO

* expand command set as other overwatch pieces are implemented
* user authentication/authorization (done in the other apps, but we'll need support here)

