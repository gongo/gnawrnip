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
  c.frame_interval_ms = 1000 # milliseconds
  c.make_animation = true
  c.max_frame_size = 1024 # pixel
end
```

* `make_animation` (Boolean) Whether to make animation GIF. (Default: true)
* `frame_interval_ms` (Integer) A time (millisecond) between each image in an animation. Default is `1000`.
    * This option is enabled only when the `make_animation = true`.
* `max_frame_size` (Integer) Maximum size that use to resize of image.
    * If given, it resize the image to fit to this value.
    * Ignored if this value is greater than original width and height.
    * Example:

      ```
         original: 640x480
       this value: 300
          result : 300x225

         original: 480x640
       this value: 400
          result : 300x400
      ```

As example, see [example/spec/spec_helper.rb](https://github.com/gongo/gnawrnip/tree/master/example/spec/spec_helper.rb) .

## Example

see https://github.com/gongo/gnawrnip/tree/master/example

## License

MIT License. see LICENSE.txt
