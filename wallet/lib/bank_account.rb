class BankAccount

  attr_accessor :currency, :amount

  def initialize(currency, amount)
    @currency = currency
    @amount = amount
  end

  def balance
    @amount
  end

end
