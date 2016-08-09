require 'net/http'
require 'json'
require 'rspec'
require 'benchmark'
require 'jsonpath'
require 'pry'

$uri_hostname = ENV['HOSTNMAME'] || "https://graph.facebook.com"
$users ||= Hash.new
$ids ||= Array.new

FACEBOOK_STORE =
    {"client_id" => "931957476934241",
     "client_secret" => "68b3a63cfb0a6e961978ddd205e005f2"
    }
