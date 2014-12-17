require 'json'
require 'representations/address'

class Person
  include Comparable

  attr_accessor :first_name, :last_name, :email, :addresses

  def initialize(entity={})
    @first_name = entity['first_name']
    @last_name = entity['last_name']
    @email = entity['email']
    @addresses = []
    entity['addresses'].each { |address| @addresses << Address.new(address) } unless entity['addresses'].nil?
  end

  def ==(obj)
    return false unless obj.is_a?(::Person)
    return false unless @first_name == obj.first_name
    return false unless @last_name == obj.last_name
    return false unless @addresses.sort == obj.addresses.sort
    true
  end

  def <=>(obj)
    last_name_comparison = @last_name <=> obj.last_name
    case last_name_comparison
      when 0
        @first_name <=> obj.first_name
      else
        last_name_comparison
    end
  end

  def to_json(*args)
    {
      :first_name => @first_name,
      :last_name => @last_name,
      :email => @email,
      :addresses => @addresses
    }.to_json
  end

  def to_s
    "#{@first_name} #{@last_name}"
  end
end