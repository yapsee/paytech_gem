# PaytechGem


Welcome to your new gem `Paytech`! This one will help you integrate easily senegalese payments aggregator [PAYTECH](https://paytech.sn/)  into your Ruby On Rails project.


## Installation

Add this line to your application's Gemfile:

    $ gem 'paytech_gem'


And then execute:

    $ bundle install

Or install it yourself as:

     $ gem install paytech_gem -v '0.1.0' 

## Usage

Create a paytech.rb file in the root of your project to configure the gem

### paytech.rb
    require 'paytech_gem'

    PaytechGem.configure do |config|
        config.paytech_api_key = 'your_api_key'
        config.paytech_api_secret = 'your_secret_key'
        config.currency = 'XOF'
        config.command_name = 'Invoice from Paytech'
        config.env = 'test'
        config.ipn_url = 'URL for IPN (Instant Payment Notification)'
        config.success_url = 'URL for successful transactions'
        config.cancel_url = 'URL for canceled transactions'


    end

 ### Use it by calling:

    invoice = PaytechGem.initialize_payment(10000, "iphone" , ref_command)
     puts invoice

    Store invoice["token"] and invoice["redirect_url"] in your database
    So you can verify transaction authenticity when Paytech call your ipn url
## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/paytech_gem.
# paytech_gem
