require "json"
require "logger"

require_relative "live_http"
require_relative "prices_fetcher"
require_relative "stock_fetcher"

$logger = Logger.new(STDOUT)
$client = LiveHttp.new

def handler(event:, context:)
  $logger.info("EVENT: #{event.inspect}")

  result = case event["path"]
           when "/prices"
             PricesFetcher.new(params: event["queryStringParameters"])
           when "/stock"
             StockFetcher.new(params: event["queryStringParameters"])
           end

  { statusCode: result.status_code, body: JSON.generate(result.body) }
end
