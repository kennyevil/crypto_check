#!/usr/bin/env ruby
require 'dotenv/load'
require 'uri'
require 'net/http'
require 'json'

class CryptoCheck
  BASE_URI = "https://api.nomics.com/v1/currencies/ticker?key=#{ENV['NOMICS_API_KEY']}".freeze

  def self.fetch_cryptocurrencies_information(crypto_currencies)
    uri = URI("#{BASE_URI}&ids=#{crypto_currencies.join(',')}")
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  end

  def self.fetch_selected_information_for_cryptocurrencies(crypto_currencies: [], attributes: [])
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
end
