# Gnawrnip

Gnawrnip is a [TurnipFormatter](https://github.com/gongo/turnip_formatter) Add-on that provides put a screen shot to report use [Capybara](https://github.com/jnicklas/capybara)

[![Build Status](https://travis-ci.org/gongo/gnawrnip.png?branch=master)](https://travis-ci.org/gongo/gnawrnip)
[![Coverage Status](https://coveralls.io/repos/gongo/gnawrnip/badge.png?branch=master)](https://coveralls.io/r/gongo/gnawrnip)
[![Code Climate](https://codeclimate.com/github/gongo/gnawrnip.png)](https://codeclimate.com/github/gongo/gnawrnip)
[![Dependency Status](https://gemnasium.com/gongo/gnawrnip.png)](https://gemnasium.com/gongo/gnawrnip)


## Requirements

* Ruby
    * `~> 1.9.3`
    * `~> 2.0.0`
* RubyGems
    * capybara `~> 2.1.0`
    * turnip_formatter

## Installation

Add this line to your application's Gemfile:

    gem 'gnawrnip'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gnawrnip

## Usage

Edit the `.rspec` file in your project directory (create it if doesn't exist), and add the following line:

    -r turnip
    -r turnip/capybara
    -r gnawrnip

And run this command.

    $ rspec --format RSpecTurnipFormatter --out report.html


## Example

see https://github.com/gongo/gnawrnip/tree/master/example

## License

MIT License. see LICENSE.txt
