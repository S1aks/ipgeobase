# frozen_string_literal: true

require_relative "test_helper"

class TestIpgeobase < Minitest::Test

  def test_that_it_has_a_version_number
    refute_nil ::Ipgeobase::VERSION
  end

  def test_get
    stub_request(:get, "http://example.com/").
      to_return(:status => 200, :body => '', :headers => {})
    response = Net::HTTP.get_response(URI.parse('http://example.com'))
    assert_equal '200', response.code
  end

  def test_ip_request
    respond_body = '<?xml version="1.0" encoding="UTF-8"?>
  <query>
  <status>success</status>
  <country>Canada</country>
  <countryCode>CA</countryCode>
  <region>BC</region>
  <regionName>British Columbia</regionName>
  <city>Vancouver</city>
  <zip>V6B</zip>
  <lat>49.282</lat>
  <lon>-123.1103</lon>
  <timezone>America/Vancouver</timezone>
  <isp>Novus Entertainment Inc.</isp>
  <org>Novus Entertainment Inc</org>
  <as>AS40029 Novus Entertainment Inc.</as>
  <query>64.46.9.1</query>
</query>'
    ip_str = '64.46.9.1'
    stub_request(:get, "http://ip-api.com/xml/#{ip_str}")
      .to_return(:status => 200, :body => respond_body, :headers => {})
    geodata = Ipgeobase.lookup(ip_str)
    assert_equal geodata.city, 'Vancouver'
    assert_equal geodata.country, 'Canada'
    assert_equal geodata.countryCode, 'CA'
    assert_equal geodata.lat, 49.282
    assert_equal geodata.lon, -123.1103
  end
end

