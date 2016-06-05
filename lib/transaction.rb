class Transaction
  @@id           = 0
  @@transactions = []

  attr_reader :id, :customer, :product, :cancelled

  def initialize(customer, product)
    raise OutOfStockError, "#{product.title} is out of stock" unless product.stock > 0

    @@id          += 1
    @id           = @@id
    product.stock -= 1

    @@transactions << self

    @customer = customer
    @product  = product
  end

  def cancel
    raise DuplicateCancelError, "#{@id}" unless !@cancelled
    @product.stock += 1
    @cancelled     = true
  end

  def self.find(id)
    @@transactions.select { |transaction| transaction.id == id }[0]
  end

  def self.find_by_product(product)
    @@transactions.select { |transaction| transaction.product == product }
  end

  def self.all
    @@transactions
  end

end