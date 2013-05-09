require 'bigdecimal'

class WalletAccount

  attr_accessor :currency, :amount

  def initialize(currency, amount)
    if [:usd, :pln, :eur, :gbp, :chf, :jpy].include?(currency)
      @currency = currency
    else
      raise IllegalArgument
    end
    temporary_amount = BigDecimal.new(amount)
    if temporary_amount < 0
      raise NotEnaughMoney
    else
      @amount = temporary_amount
    end
  end

  def balance
    @amount
  end

end
