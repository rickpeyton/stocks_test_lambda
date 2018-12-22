class PricesFetcher
  attr_reader :body, :status_code

  def initialize(params:)
    @params = params

    return unless valid?

    @status_code = 200
    @body = fetch_prices
  end

private

  def valid?
    return bad_request unless @params.key?("symbols")

    true
  end

  def bad_request
    @status_code = 400
    @body = "Missing symbols"
    false
  end

  def fetch_prices
    @params["symbols"]
      .split(",")
      .map do |symbol|
        result = $client.get(url: price_url(symbol))
        price = result.dig("Global Quote", "05. price").to_f
        { symbol => price }
      end
  end

  def price_url(symbol)
    "https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=#{symbol}&apikey=#{ENV['ALPHAVANTAGE']}"
  end
end
