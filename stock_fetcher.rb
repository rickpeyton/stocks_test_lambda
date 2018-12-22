class StockFetcher
  attr_reader :body, :status_code

  def initialize(params:)
    @params = params

    return unless valid?

    @status_code = 200
    @body = fetch_stock_and_price
  end

private

  def valid?
    return bad_request unless @params.key?("symbol")

    true
  end

  def bad_request
    @status_code = 400
    @body = "Missing symbol"
    false
  end

  def fetch_stock_and_price
    symbol = @params["symbol"]
    name = $client
           .get(url: stock_url(symbol))
           .dig("bestMatches")
           .first.dig("2. name")
    price = $client.get(url: price_url(symbol)).dig("Global Quote", "05. price").to_f
    { symbol: symbol, name: name, price: price }
  end

  def stock_url(symbol)
    "https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=#{symbol}&apikey=#{ENV['ALPHAVANTAGE']}"
  end

  def price_url(symbol)
    "https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=#{symbol}&apikey=#{ENV['ALPHAVANTAGE']}"
  end
end
