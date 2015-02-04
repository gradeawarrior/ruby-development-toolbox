require 'helper'
require 'toolbox/http'
require 'net/http'

class TestToolboxHttp < Test::Unit::TestCase

  should 'be able to make a simple request to google' do
    response = Toolbox::Http.request(:method => 'GET', :url => 'http://www.google.com')
    assert_equal(200.to_s, response.code)
  end

  should 'be able to make a simple request to google using Net::Http::Get Request' do
    req = Net::HTTP::Get.new("/", {})
    response = Toolbox::Http.request(:url => 'http://www.google.com', :request => req)
    assert_equal(200.to_s, response.code)
  end

end