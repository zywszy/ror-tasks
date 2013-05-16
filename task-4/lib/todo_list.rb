require 'active_record'

class TodoList < ActiveRecord::Base
  belongs_to :user
  has_many :todo_items

  validate :title,                :presence => true

  validate :user_id,              :presence => true,
                                  :numericality => { :only_integer => true }

end

