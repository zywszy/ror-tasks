require_relative 'spec_helper'
require_relative '../../lib/wallet_account_supplier'
require_relative '../../lib/exceptions'
require_relative '../../lib/money'

describe WalletAccountSupplier do
  subject(:supplier)         { WalletAccountSupplier.new(:bank_account, :wallet_account) }
  let(:bank_account)         { mock }
  let(:wallet_account)       { mock }

  it "should put nil to wallet_account, if 2nd argument is not provided" do  
    new_supplier = WalletAccountSupplier.new(:bank_account)
    new_supplier.wallet_account.should == nil
  end


  
end
