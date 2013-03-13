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

end
