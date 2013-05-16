require_relative 'test_helper'
require_relative '../lib/user'

describe User do
  include TestHelper

  it "" do
    user = User.first
    user.forename.should == "Sztefan"
    user.surename.should == "Was"
    user.email.should == "sztefan@4fun.tv"
    user.failed_login_count.should == 0
  end

  it "should persist itself" do
    User.create(:forename => "Andrzej", :surename => "Szczelba", :password => "Andrzej123", :email => "Andrzej.Szczelba@4fun.tv", :failed_login_count => 0)
    User.first.forename.should == "Sztefan"
    User.last.forename.should == "Andrzej"
    User.count.should == 2
  end

# To long forename, but no error occures
  it "" do
    user = User.create(:forename => "MarianMarianMarianMarianMarianMarianMarianMarian", :surename => "Badgirl", :password => "Marian123", :email => "Marian@4fun.tv", :failed_login_count => -3)
  end

end
