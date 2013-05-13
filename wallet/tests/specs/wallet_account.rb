require_relative 'spec_helper'
require_relative '../../lib/wallet_account'
require_relative '../../lib/exceptions'
require_relative '../../lib/money'

describe WalletAccount do
  subject(:wallet_account)         {WalletAccount.new(:usd, '100')}
  let(:currency)                   {:usd}
  let(:amount)                     {100}

  it "should raise an exception while creating WalletAccount object when provided currency doesn't exist in application's database" do
    expect{ WalletAccount.new(:abc, '10') }.to raise_error(IllegalArgument)
  end
  
  it "should raise an exception if provided amount is negative" do
    expect{ WalletAccount.new(:gbp, '-10') }.to raise_error(NotEnaughMoney)
  end
  
  it "should return acount balance" do
    wallet_account.balance.should == Money('100')
  end
end
