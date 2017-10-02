# SysLibs

SysLibs is a gem that collects all project's gems and retrieves the required system libraries for each in order to work. Thsi would prevent getting stuck with unknown errors when installing gems since we would now know the missing ones in advance. 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sys_libs'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sys_libs

## Usage

    $ bundle exec sys_libs

The gem will now collect all project's gems, send them to the server and retrieve the list of required system libraries for each gem.

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/sys_libs.
