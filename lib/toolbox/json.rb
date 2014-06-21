require 'json'

class Array

  ##
  # Adds in-line ability to pretty-print an Array to JSON using entity.pretty_generate
  #
  def to_json_pp
    JSON.pretty_generate(self)
  end

end

class Hash

  ##
  # Adds in-line ability to pretty-print a Hash to JSON using entity.pretty_generate
  #
  def to_json_pp
    JSON.pretty_generate(self)
  end
end

module Toolbox

  ##
  # Extends the functionality of String to support pretty_printing json.
  # This is really a natural extension of the basic String type to support
  # JSON.pretty_generate(string).
  #
  # == Usage
  #
  #     puts %w{ foo bar hello world }.to_json_pp
  #     puts [{:hello => 'world',:find => 'waldo'}].to_json_pp
  #     puts {:foo => 'bar', :hello => 'world'}.to_json_pp
  #     puts {:foo => 'bar', :hello => ['world']}.to_json_pp
  #
  module Json
  end

end
