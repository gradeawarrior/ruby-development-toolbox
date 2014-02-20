##
# Extending String function to be able to convert a String 'true' or 'false' to a boolean true/false
#
class String
  def to_bool
    (self =~ /^true$/i) == 0
  end
end

##
# Implementing to_bool operation that returns self
#
class TrueClass
  def to_bool
    self
  end
end

##
# Implementing to_bool operation that returns self
#
class FalseClass
  def to_bool
    self
  end
end

##
# Implementing to_bool operation that returns self
#
class NilClass
  def to_bool
    self
  end
end