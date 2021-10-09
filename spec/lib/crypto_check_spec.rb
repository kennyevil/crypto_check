RSpec.describe CryptoCheck do
  describe "#fetch_cryptocurrencies_information" do
    context 'for one cryptocurrency' do
      it 'will provide the payload for the requested cryptocurrency', :vcr do
        payload = CryptoCheck.fetch_cryptocurrencies_information(['BTC'])

        expect(payload.first["id"]).to eq("BTC")
      end

      it 'will provide the full payload for the requested cryptocurrency', :vcr do
        payload = CryptoCheck.fetch_cryptocurrencies_information(['BTC'])

        expect(payload.first.keys).to match_array(["id", "currency", "symbol", "name", "logo_url", "status", "price", "price_date", "price_timestamp", "circulating_supply", "max_supply", "market_cap", "market_cap_dominance", "num_exchanges", "num_pairs", "num_pairs_unmapped", "first_candle", "first_trade", "first_order_book", "rank", "rank_delta", "high", "high_timestamp", "1d", "7d", "30d", "365d", "ytd"])
      end
    end

    context 'for multiple cryptocurrencies' do
      it 'will provide the payload for the requested cryptocurrency', :vcr do
        payload = CryptoCheck.fetch_cryptocurrencies_information(['BTC', 'XRP', 'ETH'])
        payload_ids = payload.map { |hash| hash["id"] }

        expect(payload_ids).to match_array(["BTC", "XRP", "ETH"])
      end
    end
  end

  describe '#fetch_selected_information_for_cryptocurrencies' do
    it 'will provide the requested information for the selected crytocurrencies only', :vcr do
      payload = CryptoCheck.fetch_selected_information_for_cryptocurrencies(crypto_currencies: ['BTC', 'XRP', 'ETH'], attributes: ["circulating_supply", "max_supply", "name", "symbol", "price"])

      expect(payload.first.keys).to match_array(["id", "circulating_supply", "max_supply", "name", "symbol", "price"])
    end

    it 'will provide the requested information for only the selected crytocurrencies only', :vcr do
      payload = CryptoCheck.fetch_selected_information_for_cryptocurrencies(crypto_currencies: ['BTC', 'XRP', 'ETH'], attributes: ["circulating_supply", "max_supply", "name", "symbol", "price"])
      payload_ids = payload.map { |hash| hash["id"] }

      expect(payload_ids).to match_array(["BTC", "XRP", "ETH"])
    end
  end

  describe '#fetch_fiat_amount_for_crypto' do
    it 'will output a hash with the selected fiat amount for the selected cryptocurrency', :vcr do
      expect(CryptoCheck.fetch_fiat_amount_for_crypto(crypto: 'BTC', fiat: 'USD')).to eq({'BTC': { 'USD': 55069.09039011 } })
    end
  end
end
