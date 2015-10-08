require 'sinatra'
require 'net/http'
require 'uri'
require 'json'
require 'openssl'
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

get '/' do
  query   = params['search'].gsub(" ", ",") if params['search']
  results = nil
  if query
    uri = URI.parse("https://www.googleapis.com/youtube/v3/search?part=snippet&q=#{query}&key=AIzaSyD6LCx-xYsvUUfeVUf3TCLQTqQtvAmbGXg&maxResults=3")
    results = JSON.parse(Net::HTTP.get(uri))
    erb :search, :locals => {results: results['items']}
  else
    erb :search, :locals => {results: results}
  end
end
