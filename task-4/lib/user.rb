require 'active_record'

class User < ActiveRecord::Base
  has_many :todo_lists
  has_many :todo_items, :through => :todo_lists

  validate :forename,             :presence => true,
                                  :length => { :maximum => 20, :too_long => "20 characters only!" }

  validate :surename,             :presence => true,
                                  :length => { :maximum => 30, :too_long => "20 characters only!" }

  validate :email,                :presence => true,
                                  :uniqueness => true,
                                  :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :message => "It's not an email format!" }

  validate :password,             :presence => true,
                                  :confirmation => true,
                                  :length => { :minimum => 10, :too_short => "10 characters at least" }

  validate :failed_login_count,   :presence => true,
                                  :numericality => { :only_integer => true, :greater_than => 0 }
 
end

