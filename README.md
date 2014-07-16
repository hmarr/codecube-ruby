# Codecube Ruby Client Library

[![Gem Version](https://badge.fury.io/rb/codecube.png)](http://badge.fury.io/rb/codecube)

A Ruby client library for the codecube.io API

## Installation

Add this line to your application's Gemfile:

    gem 'codecube'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install codecube

## Usage

Initialize with your API key:

```ruby
CodeCube.api_key = ENV.fetch('CODECUBE_API_KEY')
```

Run code:

```ruby
response = CodeCube.run_sync(language: "ruby", code: "puts 'hello!'")
puts response.text_output
# => hello!
```

