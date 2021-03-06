class String

  ##
  # Extending String function to be able to convert a String 'true' or 'false' to a boolean true/false.
  # See the Boolean module for usage
  #
  def to_bool
    (self =~ /^true$/i) == 0
  end

end

class TrueClass

  ##
  # Implementing to_bool operation that returns self.
  # See the Boolean module for usage
  #
  def to_bool
    self
  end

end

class FalseClass

  ##
  # Implementing to_bool operation that returns self.
  # See the Boolean module for usage
  #
  def to_bool
    self
  end

end

class NilClass

  ##
  # Implementing to_bool operation that returns self.
  # See the Boolean module for usage
  #
  def to_bool
    self
  end

end

module Toolbox

  ##
  # The main application of the Boolean module is to
  # support reading boolean values from a String (e.g.
  # while reading a configuration value) and having the
  # ability to convert it back to a boolean true/false
  # for easier evaluation in your Ruby code
  #
  # == Usage
  #
  # Working with Boolean module can be very simple, for example:
  #
  #     require 'toolbox/boolean'
  #
  #     list_of_values = [
  #       'true',
  #       'True',
  #       'TRUE',
  #       'false',
  #       'False',
  #       'FALSE',
  #       nil,
  #     ]
  #
  #     list_of_values.each do |string|
  #       puts "This evaluated to true" if string.to_bool
  #       puts "This evaluated to false or was nil" unless string.to_bool
  #     end
  #
  module Boolean
  end

end