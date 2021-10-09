RSpec.describe CryptoCheck, "#fetch_cryptocurrencies_information" do
  context 'for one cryptocurrency' do
    it 'will provide the payload for the requested cryptocurrency', :vcr do
      payload = CryptoCheck.fetch_cryptocurrencies_information(['BTC'])

      expect(payload.first["id"]).to eq("BTC")
    end

    it 'will provide the full payload for the requested cryptocurrency', :vcr do
      payload = CryptoCheck.fetch_cryptocurrencies_information(['BTC'])

      expect(payload.first.keys).to eq(["id", "currency", "symbol", "name", "logo_url", "status", "price", "price_date", "price_timestamp", "circulating_supply", "max_supply", "market_cap", "market_cap_dominance", "num_exchanges", "num_pairs", "num_pairs_unmapped", "first_candle", "first_trade", "first_order_book", "rank", "rank_delta", "high", "high_timestamp", "1d", "7d", "30d", "365d", "ytd"])
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
