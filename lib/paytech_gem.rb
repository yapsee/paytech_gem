# frozen_string_literal: true

require_relative "paytech_gem/version"
require 'httparty'

module PaytechGem
  class Configuration
    attr_accessor :api_key, :api_secret, :currency, :command_name,
                  :env, :ipn_url, :success_url, :cancel_url

    def initialize
      # Set default values or leave them nil
      @api_key = ENV['PAYTECH_API_KEY']
      @api_secret = ENV['PAYTECH_SECRET_KEY']
      @currency = 'XOF'
      @command_name = 'Depot compte Nessi via PayTech'
      @env = ENV['PAYTECH_ENV']
      @ipn_url = 'https://www.yapsy.sn/api/v1/paytech/ipn'
      @success_url = 'https://www.yapsy.sn/paytech/success'
      @cancel_url = 'https://www.yapsy.sn/paytech/cancel'
    end
  end

  class << self
    attr_accessor :config

    def configure
      self.config ||= Configuration.new
      yield(config)
    end

    def initialize_payment(amount, item_name, ref_command)
      url = 'https://paytech.sn/api/payment/request-payment'
      headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'API_KEY': config.paytech_api_key,
        'API_SECRET': config.paytech_api_secret
      }

      data = {
        item_name: item,
        item_price: amount,
        currency: config.currency,
        ref_command: ref_command,
        command_name: config.command_name,
        env: config.env,
        ipn_url: config.ipn_url,
        success_url: config.success_url,
        cancel_url: config.cancel_url
      }

      response = HTTParty.post(url, body: data.to_json, headers: headers)

      if response.code == 200
        json_response = JSON.parse(response.body)
        return json_response
      else
        return "Error: #{response.code} - #{response.body}"
      end
    end
  end
end

begin
  require 'paytech' # Assuming users have a paytech.rb file in their project
rescue LoadError

end
