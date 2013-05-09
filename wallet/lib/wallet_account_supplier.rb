class WalletAccountSupplier

  attr_reader :wallet_money

  def initialize(account, money=nil) 
    @account = account
    @wallet_money = money
  end
  
  def supply(amount)
    if @wallet_money == nil
      @wallet_money = WalletAccount.new(@account.currency, 0)
    end
    if @account.balance < amount
      raise NotEnaughMoney
    else
      @account.amount -= amount
      @wallet_money.amount += amount
    end
  end

end
