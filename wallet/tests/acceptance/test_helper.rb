module WalletTestHelper

#
# set_* methods will be later used just for database connection
#

  def set_account_balance(accounts)
    @accounts ||= []
    accounts.each do |currency, value|
      @accounts << BankAccount.new(currency,value)
    end
  end

  def set_money_balance(money)
    @money ||= []
    money.each do |currency, value|
      @money << WalletAccount.new(currency,value)
    end
  end

  def set_exchange_rate(rates)
    @rates ||= []
    rates.each do |(source,target), value|
      @rates << MoneyExchangeRate.new(source_currency,target_currency,value)
    end
  end

#
# end of set methods
#

  def supply_account(currency, amount)
    supplier = BankAccountSupplier.new(find_account(currency))
    supplier.supply(amount)
  end

  def supply_wallet(currency, amount)
    supplier = WalletAccountSupplier.new(find_account(currency), find_money(currency))
    supplier.supply(amount) 
    @money << WalletAccount.new(supplier.wallet_money.currency,supplier.wallet_money.amount)
  end

  def transfer_money(currency, amount)
    supplier = WalletAccountSupplier.new(find_account(currency), find_money(currency))
    supplier.supply(amount) 
  end

  def find_account(currency)
    @accounts.find{ |a| a.currency == currency }
  end
  
  def find_money(currency)
    @money.find{ |a| a.currency == currency }
  end

  def get_account_balance(currency)
    find_account(currency).balance
  end
  
  def get_money_balance(currency)
    money = find_money(currency)
    if money
      money.balance
    else
      nil
    end
  end

  def exchange_money(source_currency,target_currency,limit)
    @limit ||= get_balance(source_currency)
    exchanger = WalletAccountExchanger.new(find_money(source_currency), find_moeny(target_currency), find_rate(source_currency, target_currency))
    exchanger.exchange(limit)
  end



end 
