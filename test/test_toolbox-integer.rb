require 'helper'
require 'toolbox/integer'

class TestToolboxInteger < Test::Unit::TestCase

  should 'String is a valid integer' do
    (0..1000).each do |integer|
      assert_equal true, integer.to_s.is_i?
    end
  end

  should 'String is a negative number' do
    (-1000..0).each do |integer|
      assert_equal true, integer.to_s.is_i?
    end
  end

  should 'String is a double value' do
    ['1.0', '-1.0', '3.1415'].each do |double|
      assert_equal false, double.is_i?
    end
  end

  should 'String is not a number' do
    ['foo', 'bar', 'one', '1 another'].each do |string|
      assert_equal false, string.is_i?
    end
  end
end
