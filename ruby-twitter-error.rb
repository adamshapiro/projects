require 'Twitter'
client = Twitter::REST::Client.new do |config|
  config.consumer_key        = "xxxxxx"
  config.consumer_secret     = "xxxxxx"
  config.access_token        = "xxxxxx"
  config.access_token_secret = "xxxxxx"
end