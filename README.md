# Gnawrnip

Gnawrnip is a [TurnipFormatter](https://github.com/gongo/turnip_formatter) Add-on that provides put a screenshot (like animation gif) to report use [Capybara](https://github.com/jnicklas/capybara)

[![Build Status](https://travis-ci.org/gongo/gnawrnip.png?branch=master)](https://travis-ci.org/gongo/gnawrnip)
[![Coverage Status](https://coveralls.io/repos/gongo/gnawrnip/badge.png?branch=master)](https://coveralls.io/r/gongo/gnawrnip)
[![Code Climate](https://codeclimate.com/github/gongo/gnawrnip.png)](https://codeclimate.com/github/gongo/gnawrnip)
[![Dependency Status](https://gemnasium.com/gongo/gnawrnip.png)](https://gemnasium.com/gongo/gnawrnip)

## IMPORTANT!

This project is currently in development (frequent releases).
So it have potential for massive refactorings (that could be API breaking).


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

## Setup

In your test setup file add:

    require 'gnawrnip'
    Gnawrnip.ready!

## Customization

You can do to customize a screenshot.

```ruby
Gnawrnip.configure do |c|
  c.publisher_driver = :js
  c.make_animation   = true
  c.frame_interval   = 1000 # milliseconds
  c.frame_size       = [640, 360] # width, height
end
```

* `make_animation` (Boolean) Whether to make animation GIF. (Default: true)
* `frame_interval` (Integer) A time (millisecond) between each image in an animation. Default is `1000` (1sec)
    * This option is enabled only when the `make_animation = true`.

As example, see [example/spec/spec_helper.rb](https://github.com/gongo/gnawrnip/tree/master/example/spec/spec_helper.rb) .

## Example

see https://github.com/gongo/gnawrnip/tree/master/example

## License

MIT License. see LICENSE.txt
