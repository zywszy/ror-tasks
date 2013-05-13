require_relative 'test_helper'
require_relative '../../lib/wallet'

describe "Virtual wallet" do
  include WalletTestHelper

#
# all set_* methods are unnecessary in final version.
#

  context "With established user's bank accounts and wallet's accounts" do

    before(:each) do
      set_account_balance :pln => '1000', :eur => '10', :usd => '50', :gbp => '20'
      set_money_balance :pln => '0', :eur => '0', :usd => '200'
    end

    specify "adding money to account" do
      get_account_balance(:pln).should == Money('1000')
      get_account_balance(:eur).should == Money('10')
      supply_account(:eur, '50')
      get_account_balance(:pln).should == Money('1000')
      get_account_balance(:eur).should == Money('60')
    end

#
# nill only if there was no money with chosen currency, else it should be 0 or amount
#

    specify "supplying wallet with not existing money - GBP" do
      get_account_balance(:gbp).should == Money('20')
      get_money_balance(:gbp).should == nil
      supply_wallet(:gbp, '5')
      get_account_balance(:gbp).should == Money('15')
      get_money_balance(:gbp).should == Money('5')
    end
    
    specify "supplying wallet with existing money - PLN" do
      get_account_balance(:pln).should == Money('1000')
      get_money_balance(:pln).should == Money('0')
      supply_wallet(:pln, '100')
      get_account_balance(:pln).should == Money('900')
      get_money_balance(:pln).should == Money('100')
    end
 
    specify "supplying bank account with money in USD" do
      get_account_balance(:usd).should == Money('50')
      get_money_balance(:usd).should == Money('200')
      supply_account(:usd, '100')
      get_account_balance(:usd).should == Money('150')
      get_money_balance(:usd).should == Money('100')
    end

    specify "exchange from PLN to EUR without limit" do
      set_exchange_rate [:pln, :eur] => 0.25
      exchange_money(:pln, :eur)
      get_money_balance(:pln).should == Money('0')
      get_money_balance(:eur).should == Money('260')
    end

    specify "exchange from PLN to EUR with limit" do
      set_exchange_rate [:pln, :eur] => 0.25
      exchange_money(:pln, :eur, '100')
      get_money_balance(:pln).should == Money('900')
      get_money_balance(:eur).should == Money('35')
    end


    context "with not enough amount of money" do

      specify "exchange from EUR to PLN without limit" do
        set_exchange_rate [:eur, :pln] => 4
        exchange_money(:eur, :pln)
        get_money_balance(:pln).should == Money('1040')
        get_money_balance(:eur).should == Money('0')
      end

      specify "exchange from EUR to PLN with limit" do
        set_exchange_rate [:eur, :pln] => 4
        exchange_money_with_limit(:eur, :pln, '50')
        get_money_balance(:pln).should == Money('1040')
        get_money_balance(:eur).should == Money('0')
      end

    end

    context "With established user's stock accounts" do
      
      before(:each) do
        set_account_balance :pln => '0', :usd => '2000'
        set_stock_balance :pgnig => 200
        set_stock_price :goog => [813, :usd], :pgnig => [5.29, :pln]
      end

      specify "buying stock with limit" do
        get_stock_balance(:goog).should == nil
        get_money_balance(:usd).should == Money('2000')
        buy_stock(:goog, 1)
        get_stock_balance(:goog).should == 1
        get_money_balance(:usd).should == Money('1187')
      end
      
      specify "selling stock with limit" do
        get_stock_balance(:pgnig).should == nil
        get_money_balance(:pln).should == Money('0')
        sell_stock(:pgnig, 10)
        get_stock_balance(:pging).should == 190
        get_money_balance(:pln).should == Money('52.9')
      end
      
      specify "buying stock without limit" do
        get_stock_balance(:goog).should == nil
        get_money_balance(:usd).should == Money('2000')
        buy_stock(:goog)
        get_stock_balance(:goog).should == 2
        get_money_balance(:usd).should == Money('374')
      end
      
      specify "selling stock without limit" do
        get_stock_balance(:pgnig).should == nil
        get_money_balance(:pln).should == Money('0')
        sell_stock(:pgnig)
        get_stock_balance(:pging).should == 0
        get_money_balance(:pln).should == Money('1058')
      end

    end

  end
end
