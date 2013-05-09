require_relative './test_helper'
require_relative '../../lib/account'

describe "Virtual wallet" do
  include WalletTestHelper
  context "With established user accounts" do

    before(:each) do
      set_account_balance :pln => 1000, :eur => 10, :usd => 50
    end

    specify "adding money to account" do
      get_account_balance(:pln).should == 1000
      get_account_balance(:eur).should == 10
    end
  end
end

