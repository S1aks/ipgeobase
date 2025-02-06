require 'happymapper'

class Geodata
  include HappyMapper

  tag 'query'
  element :city, String
  element :country, String
  element :countryCode, String
  element :lat, Float
  element :lon, Float
end
