#!/usr/bin/env ruby
require 'dotenv/load'
require 'uri'
require 'net/http'
require 'json'

class CryptoCheck
  BASE_URI = "https://api.nomics.com/v1/currencies/ticker?key=#{ENV['NOMICS_API_KEY']}".freeze

  class << self
    def fetch_cryptocurrencies_information(crypto_currencies)
      uri = URI("#{BASE_URI}&ids=#{crypto_currencies.join(',')}")
      response = Net::HTTP.get(uri)
      JSON.parse(response)
    end

    def fetch_selected_information_for_cryptocurrencies(crypto_currencies: [], attributes: [])
      attributes << "id"
      uri = URI("#{BASE_URI}&ids=#{crypto_currencies.join(',')}&attributes=#{attributes.join(',')}")
      response = Net::HTTP.get(uri)
      parsed_response = JSON.parse(response)

      parsed_response.map do |hash|
        {}.tap do |new_hash|
          attributes.each do |key|
            new_hash[key] = hash[key]
          end
        end
      end
    end

    def fetch_fiat_amount_for_crypto(crypto: '', fiat: '')
      uri = URI("#{BASE_URI}&ids=#{crypto}&convert=#{fiat}")
      response = Net::HTTP.get(uri)
      parsed_response = JSON.parse(response)

      { "#{crypto}": { "#{fiat}": parsed_response.first["price"].to_f } }
    end
  end
end
