require 'json'

class Address
  include Comparable

  attr_accessor :address1, :address2, :city, :state, :zip

  def initialize(entity={})
    @address1 = entity['address1']
    @address2 = entity['address2']
    @city = entity['city']
    @state = entity['state']
    @zip = entity['zip']
  end

  def ==(obj)
    return false unless obj.is_a?(::Address)
    return false unless @address1 == obj.address1
    return false unless @address2 == obj.address2
    return false unless @city == obj.city
    return false unless @state == obj.state
    return false unless @zip == obj.zip
    true
  end

  def <=>(obj)
    address1 = @address1 <=> obj.address1
    address2 = @address2 <=> obj.address2
    city = @city <=> obj.city
    state = @state <=> obj.state
    zip = @zip <=> obj.zip

    case address1
      when 0
        case address2
          when 0
            case city
              when 0
                case state
                  when 0
                    zip
                  else
                    state
                end
              else
                city
            end
          else
            address2
        end
      else
        address1
    end
  end

  def to_json(*args)
    {
      :address1 => @address1,
      :address2 => @address2,
      :city => @city,
      :state => @state,
      :zip => @zip
    }.to_json
  end

end