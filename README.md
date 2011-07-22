# Installation

  gem install overwatch-cli

  
# Usage

    I'm going to assume you've got overwatch-collection running somewhere on your local machine for the purpose of this documention.

## Help!

All commands provide a contextual help menu. Apped `--help` to the end of any command or subcommand to bring up its specific help menu.

## Main command

When you install `overwatch-cli` via RubyGems, an executable, `overwatch`, is installed somewhere in your $PATH (the exact location is entirely dependent upon your Ruby/Gems setup).

#### Usage:
    overwatch [OPTIONS] SUBCOMMAND [ARGS] ...

#### Parameters

* SUBCOMMAND                    subcommand name
* [ARGS] ...                    subcommand arguments

#### Subcommands

* resource                      Resources
* snapshot                      Snapshots

## Subcommands

### overwatch resource

#### Usage
    
    overwatch resource [OPTIONS] SUBCOMMAND [ARGS] ...

#### Parameters
        
* SUBCOMMAND                    subcommand name
* [ARGS] ...                    subcommand arguments

#### Subcommands

* list                          list all resources
* show                          show a specific resource
* create                        create a new resource
* update                        update an existing resource
* delete                        delete an existing resource
* regenerate                    regenerate a resource's API key

#### Options

* -h, --host HOST               overwatch-collection server (default: "localhost")
* -p, --port PORT               overwatch-collection port (default: "9001")
* -f, --format [FORMAT]         format (choices: pretty, json, text) (default: "pretty")

### overwatch resource list

#### Usage
      
    overwatch resource list [OPTIONS]

#### Options

* -h, --host HOST               overwatch-collection server (default: "localhost")
* -p, --port PORT               overwatch-collection port (default: "9001")
* -f, --format [FORMAT]         format (choices: pretty, json, text) (default: "pretty")

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

* NAME                          resource name

#### Options

* -a, --attributes              list all resource attributes
* -h, --host HOST               overwatch-collection server (default: "localhost")
* -p, --port PORT               overwatch-collection port (default: "9001")
* -f, --format [FORMAT]         format (choices: pretty, json, text) (default: "pretty")

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

* dotfile for configuration of defaults
* expand command set as other overwatch pieces are implemented
* user authentication/authorization (done in the other apps, but we'll need support here)

