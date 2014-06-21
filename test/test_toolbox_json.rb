require 'helper'
require 'toolbox/json'

class TestToolboxJson < Test::Unit::TestCase

  should 'be able to pretty-print an Array' do
    assert_equal %Q|[\n\n]|, [].to_json_pp
    assert_equal %Q|[\n  "foo",\n  "bar"\n]|, %w{ foo bar }.to_json_pp
  end

  should "be able to pretty-print an Array of Hash's" do
    assert_equal %Q|[\n  {\n  }\n]|, [{}].to_json_pp
    assert_equal %Q|[\n  {\n    "foo": "bar"\n  }\n]|, [{:foo => 'bar'}].to_json_pp
  end

  should 'be able to pretty-print a Hash' do
    assert_equal %Q|{\n}|, {}.to_json_pp
    assert_equal %Q|{\n  "foo": "bar",\n  "hello": "world"\n}|, {:foo => 'bar', :hello => 'world'}.to_json_pp
  end

  should "be able to pretty-print a Hash containing Array's" do
    assert_equal %Q|{\n  "array": [\n\n  ]\n}|, {:array => []}.to_json_pp
    assert_equal %Q|{\n  "array": [\n    "hello"\n  ]\n}|, {:array => ['hello']}.to_json_pp
  end

end