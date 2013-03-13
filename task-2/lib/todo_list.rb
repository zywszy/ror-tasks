class TodoList

  # Initialize the TodoList with +items+ (empty by default).
  def initialize(items=[])
    if items[:db] == nil
      raise IllegalArgument
    elsif
      @database = items[:db]
    end
  end

  def size
    @database.items_count
  end

  def empty?
    true if @database.items_count == 0
  end

  def << (other_object)
    begin
      @database.add_todo_item(other_object)
    rescue
    end
  end

  def first
    @database.get_todo_item(0)
  end

  def last
    @database.get_todo_item(self.size - 1)
  end

end
