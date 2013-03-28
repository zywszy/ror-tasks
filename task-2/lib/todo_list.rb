class TodoList

  # Initialize the TodoList with +items+ (empty by default).
  def initialize(items=[])
    if items[:db].nil?
      raise IllegalArgument
    elsif
      @database = items[:db]
      @social_network = items[:social_network]
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
        @social_network.spam(other_object[:title] + " added!")
      end
    end
#    other_object[:title] == "" ? nil : @database.add_todo_item(other_object)
  end

  def first
    self.size == 0 ? nil : @database.get_todo_item(0)
  end

  def last
    self.size == 0 ? nil : @database.get_todo_item(self.size - 1)
  end

  def toggle_state(index)
    if @database.get_todo_item(index) == nil
      raise Exception
    else
      @database.completed_item?(index) ? @database.complete_todo_item(index,false) : @database.complete_todo_item(index, true)
    end
  end

end
