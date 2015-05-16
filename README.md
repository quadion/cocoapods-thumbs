# Cocoapods thumbs

cocoapods-thumbs is a simple implementation of a graylist (whitelist + blacklist) for Podspecs.

When run, cocoapods will check either the full Podfile or a single Podspec against votes stored in a server
and report them back to the user.

The server needs only to return a JSON (with a syntax similar to the one available at https://github.com/quadion/thumbs/blob/master/list.json).

While more elaborate servers providing means for users to vote with a UI can be created, using a GitHub repository with a single JSON file and voting through Pull Requests could suffice in most cases (this is what we do, our repo is https://github.com/quadion/thumbs).

## Installation

    $ gem install cocoapods-thumbs

## Usage

### Setting the server

Set the server URL by calling:

    $ pod thumbs server URL
    
### Checking a full Podfile

On the same directory your Podfile is, run:

    $ pod thumbs
    
### Checking a single Podspec

To check a single Podspec run:

    $ pod thumbs NAME REQUIREMENT
    
Where VERSION is a version requirement with the same supported syntax as in a Podfile.

By default, this will use a platform os iOS 8.3. If you want to override the platform and version you can add:

    $ pod thumbs NAME REQUIREMENT --platform=osx --version=10.10
