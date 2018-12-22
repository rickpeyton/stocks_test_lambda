RSpec.describe "#handler" do
  context "prices request" do
    it "returns stock prices" do
      allow_any_instance_of(Logger).to receive(:info).and_return(nil)
      allow_any_instance_of(LiveHttp).to receive(:get).and_return(fake_quote)
      event = prices_request
      context = ""

      result = handler(event: event, context: context)

      expect(result.dig(:body).from_json.map(&:keys).flatten).to match_array prices_response
    end
  end

  context "stock request" do
    it "returns the stock and its price" do
      allow_any_instance_of(Logger).to receive(:info).and_return(nil)
      allow_any_instance_of(LiveHttp).to receive(:get).with(url: /function=SYMBOL_SEARCH/).and_return(fake_stock)
      allow_any_instance_of(LiveHttp).to receive(:get).with(url: /function=GLOBAL_QUOTE/).and_return(fake_quote)
      event = stock_request
      context = ""

      result = handler(event: event, context: context)

      expect(result.dig(:body).from_json).to eq stock_response
    end
  end
end

def prices_request
  { "resource" => "/prices", "path" => "/prices", "httpMethod" => "GET", "headers" => { "CloudFront-Forwarded-Proto" => "https", "CloudFront-Is-Desktop-Viewer" => "true", "CloudFront-Is-Mobile-Viewer" => "false", "CloudFront-Is-SmartTV-Viewer" => "false", "CloudFront-Is-Tablet-Viewer" => "false", "CloudFront-Viewer-Country" => "US", "Content-Type" => "application/json; charset=utf-8", "Host" => "4ykxh7xtk3.execute-api.us-east-1.amazonaws.com", "User-Agent" => "Paw/3.1.8 (Macintosh; OS X/10.13.6) GCDHTTPRequest", "Via" => "1.1 aec68543cec4f736ed512388e8c22034.cloudfront.net (CloudFront)", "X-Amz-Cf-Id" => "CO4U-PYVz80vMuW6temF-HLGUT5epf9K6ZCiYmL1ugWQf4ij0iHIdA==", "X-Amzn-Trace-Id" => "Root=1-5c1eb149-ec07e90c19600614635f5643", "X-Forwarded-For" => "99.160.140.87, 54.239.170.64", "X-Forwarded-Port" => "443", "X-Forwarded-Proto" => "https" }, "multiValueHeaders" => { "CloudFront-Forwarded-Proto" => ["https"], "CloudFront-Is-Desktop-Viewer" => ["true"], "CloudFront-Is-Mobile-Viewer" => ["false"], "CloudFront-Is-SmartTV-Viewer" => ["false"], "CloudFront-Is-Tablet-Viewer" => ["false"], "CloudFront-Viewer-Country" => ["US"], "Content-Type" => ["application/json; charset=utf-8"], "Host" => ["4ykxh7xtk3.execute-api.us-east-1.amazonaws.com"], "User-Agent" => ["Paw/3.1.8 (Macintosh; OS X/10.13.6) GCDHTTPRequest"], "Via" => ["1.1 aec68543cec4f736ed512388e8c22034.cloudfront.net (CloudFront)"], "X-Amz-Cf-Id" => ["CO4U-PYVz80vMuW6temF-HLGUT5epf9K6ZCiYmL1ugWQf4ij0iHIdA=="], "X-Amzn-Trace-Id" => ["Root=1-5c1eb149-ec07e90c19600614635f5643"], "X-Forwarded-For" => ["99.160.140.87, 54.239.170.64"], "X-Forwarded-Port" => ["443"], "X-Forwarded-Proto" => ["https"] }, "queryStringParameters" => { "symbols" => "aapl,msft,vtsax" }, "multiValueQueryStringParameters" => { "symbols" => ["appl,msft,vti"] }, "pathParameters" => nil, "stageVariables" => nil, "requestContext" => { "resourceId" => "5tjg00", "resourcePath" => "/prices", "httpMethod" => "GET", "extendedRequestId" => "SVCjgGPcoAMFYmQ=", "requestTime" => "22/Dec/2018:21:48:57 +0000", "path" => "/Prod/prices", "accountId" => "392957558567", "protocol" => "HTTP/1.1", "stage" => "Prod", "domainPrefix" => "4ykxh7xtk3", "requestTimeEpoch" => 1_545_515_337_675, "requestId" => "6279aaab-0633-11e9-9b8b-ebf736ad916d", "identity" => { "cognitoIdentityPoolId" => nil, "accountId" => nil, "cognitoIdentityId" => nil, "caller" => nil, "sourceIp" => "99.160.140.87", "accessKey" => nil, "cognitoAuthenticationType" => nil, "cognitoAuthenticationProvider" => nil, "userArn" => nil, "userAgent" => "Paw/3.1.8 (Macintosh; OS X/10.13.6) GCDHTTPRequest", "user" => nil }, "domainName" => "4ykxh7xtk3.execute-api.us-east-1.amazonaws.com", "apiId" => "4ykxh7xtk3" }, "body" => nil, "isBase64Encoded" => false }
end

def stock_request
  { "resource" => "/stock", "path" => "/stock", "httpMethod" => "GET", "headers" => { "CloudFront-Forwarded-Proto" => "https", "CloudFront-Is-Desktop-Viewer" => "true", "CloudFront-Is-Mobile-Viewer" => "false", "CloudFront-Is-SmartTV-Viewer" => "false", "CloudFront-Is-Tablet-Viewer" => "false", "CloudFront-Viewer-Country" => "US", "Host" => "4ykxh7xtk3.execute-api.us-east-1.amazonaws.com", "User-Agent" => "Paw/3.1.8 (Macintosh; OS X/10.13.6) GCDHTTPRequest", "Via" => "1.1 768f704d00cc7858bc745d55bcdc21d7.cloudfront.net (CloudFront)", "X-Amz-Cf-Id" => "L5zj-hXUUW_TvxkUQHAetnoowIgQq9kI1LBSsdxLghlbod-XXbg9fw==", "X-Amzn-Trace-Id" => "Root=1-5c1efe0d-48c822e6aa67cb92c8507c42", "X-Forwarded-For" => "99.160.140.87, 52.46.18.78", "X-Forwarded-Port" => "443", "X-Forwarded-Proto" => "https" }, "multiValueHeaders" => { "CloudFront-Forwarded-Proto" => ["https"], "CloudFront-Is-Desktop-Viewer" => ["true"], "CloudFront-Is-Mobile-Viewer" => ["false"], "CloudFront-Is-SmartTV-Viewer" => ["false"], "CloudFront-Is-Tablet-Viewer" => ["false"], "CloudFront-Viewer-Country" => ["US"], "Host" => ["4ykxh7xtk3.execute-api.us-east-1.amazonaws.com"], "User-Agent" => ["Paw/3.1.8 (Macintosh; OS X/10.13.6) GCDHTTPRequest"], "Via" => ["1.1 768f704d00cc7858bc745d55bcdc21d7.cloudfront.net (CloudFront)"], "X-Amz-Cf-Id" => ["L5zj-hXUUW_TvxkUQHAetnoowIgQq9kI1LBSsdxLghlbod-XXbg9fw=="], "X-Amzn-Trace-Id" => ["Root=1-5c1efe0d-48c822e6aa67cb92c8507c42"], "X-Forwarded-For" => ["99.160.140.87, 52.46.18.78"], "X-Forwarded-Port" => ["443"], "X-Forwarded-Proto" => ["https"] }, "queryStringParameters" => { "symbol" => "vsmax" }, "multiValueQueryStringParameters" => { "symbol" => ["vsmax"] }, "pathParameters" => nil, "stageVariables" => nil, "requestContext" => { "resourceId" => "bnzizv", "resourcePath" => "/stock", "httpMethod" => "GET", "extendedRequestId" => "SVyiKFlhIAMFSaQ=", "requestTime" => "23/Dec/2018:03:16:29 +0000", "path" => "/Prod/stock", "accountId" => "392957558567", "protocol" => "HTTP/1.1", "stage" => "Prod", "domainPrefix" => "4ykxh7xtk3", "requestTimeEpoch" => 1_545_534_989_889, "requestId" => "241b8b3b-0661-11e9-a278-512b6ddd4fc4", "identity" => { "cognitoIdentityPoolId" => nil, "accountId" => nil, "cognitoIdentityId" => nil, "caller" => nil, "sourceIp" => "99.160.140.87", "accessKey" => nil, "cognitoAuthenticationType" => nil, "cognitoAuthenticationProvider" => nil, "userArn" => nil, "userAgent" => "Paw/3.1.8 (Macintosh; OS X/10.13.6) GCDHTTPRequest", "user" => nil }, "domainName" => "4ykxh7xtk3.execute-api.us-east-1.amazonaws.com", "apiId" => "4ykxh7xtk3" }, "body" => nil, "isBase64Encoded" => false }
end

def prices_response
  %w(aapl msft vtsax)
end

def stock_response
  {
    "symbol" => "vsmax",
    "name" => "Vanguard Total Stock Market Index Admiral",
    "price" => 150.73
  }
end

def fake_quote
  {
    "Global Quote" => {
      "01. symbol" => "AAPL",
      "02. open" => "156.8600",
      "03. high" => "158.1500",
      "04. low" => "149.6300",
      "05. price" => "150.7300",
      "06. volume" => "95744384",
      "07. latest trading day" => "2018-12-21",
      "08. previous close" => "156.8300",
      "09. change": "-6.1000",
      "10. change percent" => "-3.8896%"
    }
  }
end

def fake_stock
  {
    "bestMatches" => [
      {
        "1. symbol" => "VTSAX",
        "2. name" => "Vanguard Total Stock Market Index Admiral",
        "3. type" => "Mutual Fund",
        "4. region" => "United States",
        "5. marketOpen" => "09:30",
        "6. marketClose" => "16:00",
        "7. timezone" => "UTC-05",
        "8. currency" => "USD",
        "9. matchScore" => "1.0000"
      }
    ]
  }
end
