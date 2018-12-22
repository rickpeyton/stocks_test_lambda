require "net/http"
require "net/https"

class LiveHttp
  def get(url:)
    uri = URI(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER
    req = Net::HTTP::Get.new(uri)
    $logger.info("Net::HTTP Request: #{req.inspect}")
    res = http.request(req)
    $logger.info("Net::HTTP Response: #{res.inspect}")
    JSON.parse(res.body)
  rescue StandardError => e
    e.message
  end
end
