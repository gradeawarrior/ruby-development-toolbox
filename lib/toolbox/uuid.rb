##
# A generic UUID class
#
# == Usage
#
#     $ irb
#     require 'toolbox/uuid'
#       => true
#     UUID.generate
#       => "0a391631-22ba-40ea-af2e-65a64de4a42b"
#     UUID.generate
#       => "092516ba-a2f4-45cf-9e1d-c5e63342aaa4"
#
class UUID

  ##
  # Generate a random UUID.
  #
  # Attempts a few different ways, hopefully one of them work. If all fails, die.
  #
  def self.generate
    begin
      require 'securerandom'
      return SecureRandom.uuid()

    rescue Exception => e
      if (File.exist?("/usr/bin/uuidgen")) # Centos e2fsprogs package
        uuid = `/usr/bin/uuidgen`
        return uuid.chomp
      elsif (File.exist?("/usr/bin/uuid")) # Debian uuid package
        uuid = `/usr/bin/uuid`
        return uuid.chomp
      end
    end
    abort("Unable to generate UUIDs")
  end

end