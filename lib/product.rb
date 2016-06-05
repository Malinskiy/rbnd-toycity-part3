require 'set'
require_relative 'errors'

class Product
  @@products = Set.new

  attr_reader :title
  attr_accessor :price, :stock

  def initialize(options={})
    @title = options[:title]
    @price = options[:price]
    @stock = options[:stock]

    if @@products.add?(self).nil?
      raise DuplicateProductError, "#{@title} already exists"
    end
  end

  def self.all
    @@products
  end

  def eql?(other)
    self.title.eql? other.title
  end

  def hash
    @title.hash
  end


end