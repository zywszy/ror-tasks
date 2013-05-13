class WalletAccountSupplier

  attr_reader :wallet_account

  def initialize(bank_account, wallet_account=nil) 
    @bank_account = bank_account
    @wallet_account = wallet_account
  end
  
  def supply(amount)
    amount = Money(amount)
    if @wallet_account == nil
      @wallet_account = WalletAccount.new(@bank_account.currency, '0')
    end
    if @bank_account.balance < amount
      raise NotEnaughMoney
    else
      @bank_account.amount -= amount
      @wallet_account.amount += amount
    end
  end

end
