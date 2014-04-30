module Gem
  class Specification

    ##
    # Provides retrieving only the latest versions of all gems on
    # your system regardless of multiple versions of a gem installed.
    #
    def self.latest_versions
      specs = Gem::Specification.find_all.map.inject({}) do |result, spec|
        if result.has_key?(spec.name) && result[spec.name].version < spec.version
          result[spec.name] = spec
        elsif !result.has_key?(spec.name)
          result[spec.name] = spec
        end
        result
      end
      specs.values
    end
  end
end

##
# Extends the functionality of a Gem::Specification to be able to retrieve the latest version of gems
# currently on your system.
#
# == Usage
#
#     Gem::Specification.latest_versions.each do |spec|
#       puts "#{spec.name} (#{spec.version})"
#     end
#
module GemSpecification
end
