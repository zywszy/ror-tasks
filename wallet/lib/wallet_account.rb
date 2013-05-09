class WalletAccount

  attr_accessor :currency, :amount

  def initialize(currency, amount)
    if [:usd, :pln, :eur, :gbp, :chf, :jpy].include?(currency)
      @currency = currency
    else
      raise IllegalArgument
    end
    if amount < 0
      raise NotEnaughMoney
    else
      @amount = amount.to_f
    end
  end

  def balance
    @amount
  end

end
