class BankAccountSupplier

  def initialize(bank_account, wallet_account=nil) 
    @bank_account = bank_account
    @wallet_account = wallet_account
  end
  
  def supply(amount)
    amount = Money(amount)
    if @wallet_account.nil?
      @bank_account.amount += amount
    else
      @bank_account.amount += amount
      @wallet_account.amount -= amount
    end
  end

end
