#!/usr/bin/env ruby
require 'dotenv/load'
require 'uri'
require 'net/http'
require 'json'

class CryptoCheck
  def self.fetch_cryptocurrencies_information(requested_crypto_currencies)
    uri = URI("https://api.nomics.com/v1/currencies/ticker?key=#{ENV['NOMICS_API_KEY']}&ids=#{requested_crypto_currencies.join(',')}")
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  end
end
