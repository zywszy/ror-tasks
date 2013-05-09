class BankAccountSupplier

  def initialize(account, money=nil)
    @account = account
    @wallet_money = money
  end

  def supply(amount)
    if @wallet_money
      @account.amount += amount
      @wallet_money.amount -= amount
    else
      @account.amount += amount
    end
  end

end
