require 'active_record'

class TodoList < ActiveRecord::Base
  belongs_to :todo_list
  
  validate :title,                :presence => true,
                                  :length => { :in => 5..30, :too_short => "5 characters at least", :too_long => "30 characters only" }

  validate :describtion           :allow_blank => true,
                                  :length => { :maximum => 255, :too_long => "255 characters only" }

  validate :date_due              :allow_blank => true,
                                  :format => { :with => /^[0-9]{2}\/[0-9]{2}\/[0-9]{4}$/ , :message => "It's not an date (dd/mm/yyyy) format!" }

# I have no idea what about this not empty list of element's, this item belongs to!

end

