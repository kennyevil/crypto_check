# CryptoCheck

CryptoCheck is a gem for accessing data about cryptocurrencies using the Nomics API

## Installation

### Prerequisites

To install and use CryptoCheck you will need the following:

Ruby 2.7+
[Bundler](https://github.com/rubygems/bundler)
[Nomics API Key](https://p.nomics.com/cryptocurrency-bitcoin-api) (note: the free version of this API key is limted to 1 request per second)

### Installing

- Clone the repository down
- Create a .env file. An example file is provided in this repository.
- Add your Nomics API key to the .env file
- Run ```bundle install```
- Run ```gem build crypto_check```
- Run ```gem install crypto_check```

## Using CryptoCheck

- Run ```irb```
- ```require 'crypto_check```
- You now have access to all of the CryptoCheck methods

### CryptoCheck methods

All of CryptoCheck's methods are class methods.

#### #fetch_cryptocurrencies_information

```CryptoCheck.fetch_cryptocurrencies_information([array of strings reqpresenting cryptocurrencies you want information on])```

This will provide an array of hashes with the information on the requested cryptocurrencies.

#### #fetch_selected_information_for_cryptocurrencies

```CryptoCheck.fetch_selected_information_for_cryptocurrencies(crypto_currencies: [array of strings reperesenting the cryptocurrencies], attributes: [array of strings representing the attributes required for the cryptocurrencies])```

This will provide the an array of hashes with the requested information.

#### #fetch_fiat_amount_for_cryptocurrencies

```CryptoCheck.fetch_fiat_amount_for_cryptocurrencies(crypto: [array of strings representing the cryptocurrencies you want information for], fiat: 'String with the symbol for the fiat currency value of the cryptocurrency')```

This will output a hash with the fiat amount for the requested cryptocurrencies, eg { BTC: { USD: 55000 } }

#### #find_conversion_values_between_cryptocurrencies

This will output a hash with the amount of one cryptocurrency that you can buy with another, eg { BTC: { XRP: 5000 } }

## Testing

This gem is tested with RSpec, using Webmock and VCR to stub out API responses so that the test suite is not too affected by the rate limiting on the API.

To run the tests run the following command ```rake test```

For new tests that require the API I used the API key provided by Nomics to build up the cassette and then deleted the key from the VCR tests. I am looking at a better way of doing this. If you add any further tests doing the **ensure that your API key has been deleted from the cassette response**. You will find it in the request uri.

If the VCR cassettes are deleted, they can be rebuilt when the test suite is run, although this will be an arduous process due to the aforementioned rate limiting on the free version of the API. As well as that the fiat values for the cryptocurrencies will have changed, so the specs will need to be updated to reflect that. My advice would be not to delete the VCR cassettes unless you have a very good reason.

# TODO

Improvements that need to be made to the gem:

- Error handling to deal with bad input or non-responsive API.
- Improved process for building the VCR cassettes for the API requests so that the API key does not have to be manually deleted.
- Change specs so they are not dependent on the set values provided in the specs, and instead are derived from the actual API responses.
