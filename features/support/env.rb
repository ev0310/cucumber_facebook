require 'net/http'
require 'json'
require 'rspec'

$uri_hostname = ENV['HOSTNMAME'] || "https://graph.facebook.com"