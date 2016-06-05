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

  def in_stock?
    @stock > 0
  end

  def self.all
    @@products
  end

  def self.find_by_title(title)
    @@products.select { |product| product.title == title }[0]
  end

  def self.in_stock()
    @@products.select { |product| product.in_stock? }
  end

  def eql?(other)
    self.title.eql? other.title
  end

  def hash
    @title.hash
  end


end