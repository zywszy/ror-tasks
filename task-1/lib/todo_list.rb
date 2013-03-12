class TodoList

  # Initialize the TodoList with +items+ (empty by default).
  def initialize(items=[])
    if items == nil
      raise IllegalArgument
    else
      @items = items
      @status = []
      @items.each do |item|
        @status << false
      end
    end
  end

  def <<(other_object)
    @items << other_object
    @status << false
  end

  def size
    @items.size
  end

  def empty?
    @items.empty?
  end

  def last()
    @items.last
  end

  def first()
    @items.first
  end

  def complete(index)
    @status[index] = true
  end

  def completed?(object)
    true if @status[object] == true
  end
  
  def uncomplete(index)
    @status[index] = false
  end

  def return_completed()
    completed_items = []
    iterator = 0
    @items.each do |item|
      completed_items << @items[iterator] if @status[iterator] == true
      iterator += 1
    end
    completed_items
  end
  
  def return_uncompleted()
    uncompleted_items = []
    iterator = 0
    @items.each do |item|
      uncompleted_items << @items[iterator] if @status[iterator] == false
      iterator += 1
    end
    uncompleted_items
  end

  def remove_items()
    @items = []
    @status = []
  end

  def delete(value)
    @status.delete_at(@items.index(value))
    @items.delete(value)
  end

  def delete_at(index)
    @status.delete_at(index)
    @items.delete_at(index)
  end

  def remove_completed
    to_remove = []
    @items.each do |item|
      if @status[@items.index(item)] == true
        to_remove << item
      end  
    end
    to_remove.each do |item|
      @status.delete_at(@items.index(item))
      @items.delete(item)
    end
    @items
  end
  
  def [](value)
    @items[value]
  end

  def []= (value, other_object)
    @items[value] = other_object
  end

  def revert(first=nil, second=nil)
    if first == nil && second == nil
      items = []
      status = []
      while !@items.empty?
        items << @items.pop
        status << @status.pop
      end
      @status = status
      @items = items
    else
      tmp = @items[first]
      tmp_status = @status[first]
      @items[first] = @items[second]
      @status[first] = @status[second]
      @items[second] = tmp
      @status[second] = tmp_status
    end
  end

  def sort()
    @items.sort!()
  end

  def print()
    puts ""
    @items.each do |item|
      if @status[@items.index(item)] == true
        print_completed_item(@items.index(item))
      else
        print_uncompleted_item(@items.index(item))
      end
    end
  end

  protected

  def print_completed_item(index)
    puts " - [x] %s" % [@items[index]]
  end

  def print_uncompleted_item(index)
    puts " - [ ] %s" % [@items[index]]
  end
end
