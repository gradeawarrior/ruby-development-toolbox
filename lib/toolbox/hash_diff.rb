##
# Extends the functionality of a Hash to be able to perform (i) diff and (ii) similarity operations
#
class Hash

  ##
  # Provides diff capabilities on a Hash. This implementation is slightly customized for
  # Proofpoint Prism service-records, but otherwise should work on any Hash
  #
  def diff(other, svc_record_map = nil)
    svc_record_map = {} unless svc_record_map.kind_of?(Hash)
    (self.keys + other.keys).uniq.inject({}) do |memo, key|
      rkeys = svc_record_map[key] || [key]
      rkeys.each do |rkey|
        diff_key = (rkeys.size > 1 || (key != rkey)) ? "#{key} --> #{rkey}" : rkey
        if self[key].kind_of?(Hash) && other[rkey].kind_of?(Hash)
          memo[diff_key] = self[key].diff(other[rkey])
        elsif self[rkey] != other[rkey]
          memo[diff_key] = [self[key], other[rkey]]
        end
      end
      memo
    end
  end

  ##
  # Provides similarity capabilities on a Hash. This implementation is slightly optimized for
  # Proofpoint Prism service-records, but otherwise should work on any Hash
  #
  # == Parameters
  #
  #   other
  #
  def similarity(other, svc_record_map = nil)
    svc_record_map = {} unless svc_record_map.kind_of?(Hash)
    (self.keys + other.keys).uniq.inject({}) do |memo, key|
      rkeys = svc_record_map.has_key?(key) ? svc_record_map[key] : [key]
      rkeys.each do |rkey|
        diff_key = (rkeys.size > 1 || (key != rkey)) ? "#{key} --> #{rkey}" : rkey
        if self[key].kind_of?(Hash) && other[rkey].kind_of?(Hash)
          memo[diff_key] = self[key].similarity(other[rkey])
        elsif self[key] == other[rkey]
          memo[diff_key] = self[key]
        end
      end
      memo
    end
  end

  ##
  # Utility for deleting any Prism service-record keys that I don't want to do a diff/similarity on
  #
  def clean
    ['svc_id', 'name', 'environment_name', 'type', 'subtype', 'note'].each { |k| self.delete k }
    self.keys.each do |svc_record_name|
      self[svc_record_name].clean() if self[svc_record_name].kind_of?(Hash)
    end
    self.keys.each do |key|
      if self[key].kind_of?(Hash) && self[key].empty?
        self.delete(key)
      elsif self[key].kind_of?(Hash)
        self[key].clean
        self.delete(key) if self[key].empty?
      end
    end
    self
  end

  ##
  # Utility for counting the number of leaf nodes in a Hash-Array structure. A leaf node is determined
  # to be anything that is a non-Hash
  #
  def count_leafs
    self.keys.inject(0) do |result, element|
      if self[element].kind_of?(Hash)
        result+=self[element].count_leafs
      else
        result+=1
      end
    end
  end

  ##
  # Return only the List of Prism service-records; if the List is empty, then return the original Hash with no filters
  # applied.
  #
  # == Parameters
  #
  #   filter_keys   : an array of keys to exclude
  #   filter_values : an array of values to exclude
  #
  def filter(filter_keys = nil, filter_values = nil)
    filter_keys = Array.new unless filter_keys.kind_of?(Array)
    filter_values = Array.new unless filter_values.kind_of?(Array)
    result = filter_keys.empty? ? self : Hash.new
    filter_keys.each do |key|
      self.keys.each do |svc_record|
        if svc_record.match(/^#{key}$/)
          result[svc_record] = self[svc_record]
        elsif svc_record.match(/^#{key} -->/)
          result[svc_record] = self[svc_record]
        end
      end
    end
    filter_values.each do |filter_value|
      result.keys.each do |key|
        if result[key].kind_of?(Hash)
          result[key] = result[key].filter(nil, filter_values)
          result.delete(key) if result[key].keys.empty?
        elsif result[key].kind_of?(Array) && key.match(/version/).nil?
          filter_triggered = false
          result[key].each do |diff_value|
            filter_triggered = diff_value =~ /#{filter_value}/
            break if filter_triggered
          end
          result.delete(key) if filter_triggered
        end
      end
    end
    result
  end
end

module Toolbox

  ##
  # Extends the functionality of a Hash to be able to perform (i) diff and (ii) similarity operations
  # For implementation details, see the Hash class for the extended functions
  #
  # == Usage
  #
  # Working with HashDiff module can be very simple, for example:
  #
  #     require 'toolbox/hash_diff'
  #     require 'yaml'
  #
  #     hash1 = {
  #       :foo => 'bar',
  #       :bar => 'hello',
  #       :hello => 'world',
  #       :this => { :exists => 'yay!' }
  #     }
  #
  #     hash2 = {
  #       :foo => 'bar',
  #       :hello => 'Hi',
  #       :this => { :exists => 'yay!' },
  #       :hey => { :this => "Doesn't exist", :but => "oh well" }
  #     }
  #
  #     puts hash1.diff(hash2).to_yaml
  #     puts hash1.similarity(hash2).to_yaml
  #
  module HashDiff
  end

end