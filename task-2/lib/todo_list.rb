class TodoList

  # Initialize the TodoList with +items+ (empty by default).
  def initialize(items=[])
    if items[:db].nil?
      raise IllegalArgument
    elsif
      @database = items[:db]
      if items[:social_network]
        @social_network = items[:social_network]
      else
        @social_network = nil
      end
    end
  end

  def size
    @database.items_count
  end

  def empty?
    true if @database.items_count == 0
  end

  def << (other_object)
    if other_object.nil? || other_object[:title] == "" || other_object[:title].size < 3
      nil
    else
      @database.add_todo_item(other_object)
      if @social_network != nil
        self.notifie(other_object[:title])
      end
    end
  end

  def first
    self.size == 0 ? nil : @database.get_todo_item(0)
  end

  def last
    self.size == 0 ? nil : @database.get_todo_item(self.size - 1)
  end

  def toggle_state(index)
    item = @database.get_todo_item(index)
    if item.nil?
      raise Exception
    else
      if @database.completed_item?(index)
        @database.complete_todo_item(index, false)
      else
        @database.complete_todo_item(index, true)
        self.notifie(item[:title])
      end
#      @database.completed_item?(index) ? @database.complete_todo_item(index,false) : @database.complete_todo_item(index, true)
    end
  end

  def notifie(title)
    if title.size > 255
#sth
      title = title[0..254]
    end
    @social_network.spam(title + " added!")       
  end

end
