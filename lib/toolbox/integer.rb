class String

  ##
  # Adds the ability to check if String is an integer (both positive and negative values accepted)
  #
  def is_i?
    !self.match(/^[-+]?[0-9]+$/).nil?
  end

end

class Integer
  def is_i?
    true
  end
end

module Toolbox

  ##
  # Extends the functionality of String to support checking if a String can be converted
  # to an Integer
  #
  # == Usage
  #
  #     ['-1', '0', '1', '1.0', 'one', '1 too many'].each do |test|
  #       puts "This can be converted to an Integer" if test.is_i?
  #       puts "This cannot be converted to an Integer" unless test.is_i?
  #     end
  #
  module Integer
  end

end
