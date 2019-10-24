# Guard::Webpacker

Guard::Webpacker automatically runs webpacker-dev-server/webpack from [rails-webpacker](https://github.com/rails/webpacker).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'guard-webpacker'
```

And then execute:

```
$ bundle
```

Or install it yourself as:

```
$ gem install guard-webpacker
```

## Usage

```
$ guard init webpacker
```

### Guardfile

```
### Guard::Webpacker
#  available options:
#  - :bin (defaults to "webpack-dev-server") to run
#  - :watch (defaults to "default") can be an array
#  - :colors (defaults to 1)
#  - :progress
guard :webpacker do
  watch('config/webpacker.yml')
  watch(%r{^config/webpacker/(.+)$})
end
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/icyleaf/guard-webpacker. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Guard::Webpacker project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/guard-webpacker/blob/master/CODE_OF_CONDUCT.md).
