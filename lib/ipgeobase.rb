# frozen_string_literal: true

require_relative "ipgeobase/version"
require_relative 'ipgeobase/geodata'
require 'addressable/uri'
require 'net/http'

module Ipgeobase
  BASE_URL = 'http://ip-api.com/xml/'

  class Error < StandardError; end

  def self.lookup(ip_str)
    request_uri = Addressable::URI.parse("#{BASE_URL}#{ip_str}")
    response = Net::HTTP.get_response(request_uri)
    Geodata.parse(response.body)
  end
end
