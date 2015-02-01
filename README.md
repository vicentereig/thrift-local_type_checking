# Thrift::LocalTypeChecking

[![Circle CI](https://circleci.com/gh/vicentereig/thrift-local_type_checking.svg?style=svg)](https://circleci.com/gh/vicentereig/thrift-local_type_checking)

Enables local type checking per client, as opposed to `Thrift.type_checking = true` flag
which affects every client running on the client application.

It also recursively validates structs.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'thrift-local_type_checking'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install thrift-local_type_checking

## Usage

```thrift
namespace rb Accounts.V1

struct EmailAddress {
   1:i64 id
   2:string email
}

struct User {
    1:i64 id
    2:required list<EmailAddress> emails
}

struct Account {
    1:i64 id
    3:list<User> users
}

service AccountsService {
  void create(1:Account account)
}

```

```ruby
client  = Accounts::V1::AccountsService::Client.new.extend(Thrift::LocalTypeChecking)
account = Accounts::V1::Account.new(id: 'not a number! =D', users: nil)
client.create(account)
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/thrift-local_type_checking/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
