class Array

  ##
  # Adds the ability to check if Array contains a subset of objects or a single object. See toolbox/array
  #
  def =~(other)
    if other.is_a?(::Array)
      other.each { |obj| return false unless self.include?(obj) }
      true
    else
      self.include?(other)
    end
  end

  alias_method :contains?, :=~

end

module Toolbox

  ##
  # This is to implement equivalence check for arrays. In the context of arrays,
  # we use =~ as a means of checking if array1 is contained in array2; or if
  # object is contained in array1
  #
  #   sample_array = [1, 2, 3]
  #   puts sample_array =~ 3    ## This prints true
  #   puts sample_array =~ 4    ## This prints false
  #
  # The other way is the following:
  #
  #   sample_array1 = [1, 2, 3]
  #   sample_array2 = [1, 2, 3, 4]
  #
  #   puts sample_array2 =~ sample_array1   ## This prints true, because everything in array1 is in array2
  #   puts sample_array1 =~ sample_array2   ## This prints false, because not everything in array2 is in array1
  #
  module Array
  end

end
