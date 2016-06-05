require 'set'
require_relative 'errors'

class Customer
  @@customers = Set.new

  attr_reader :name

  def initialize(options={})
    @name = options[:name]

    if @@customers.add?(self).nil?
      raise DuplicateCustomerError, "#{name} already exists"
    end
  end

  def self.find_by_name(name)
    @@customers.select { |customer| customer.name == name }[0]
  end

  def eql?(other)
    @name.eql?(other.name)
  end

  def hash
    @name.hash
  end

end