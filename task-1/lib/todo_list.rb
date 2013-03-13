class TodoList

  # Initialize the TodoList with +items+ (empty by default).
  def initialize(items=[])
    if items == nil
      raise IllegalArgument
    else
      @items = items
      @tasks = {}
      @items.each do |item|
        @tasks[item] = false
      end
    end
  end

  def <<(other_object)
    @items << other_object
    @tasks[other_object] = false
  end

  def size
    @items.size
  end

  def empty?
    @items.empty?
  end

  def last
    @items.last
  end

  def first
    @items.first
  end

  def complete(index)
    @tasks[@items[index]] = true
  end

  def completed?(object)
    true if @tasks[@items[object]] == true
  end
  
  def uncomplete(index)
    @tasks[@items[index]] = false
  end

  def return_completed
    completed_items = []
    @items.each do |item|
      completed_items << item if @tasks[item] == true
    end
    completed_items
  end
  
  def return_uncompleted
    uncompleted_items = []
    @items.each do |item|
      uncompleted_items << item if @tasks[item] == false
    end
    uncompleted_items
  end

  def remove_items
    @items = []
    @tasks = {}
  end

  def delete(value)
    @items.delete_at(@items.index(value))
    @tasks.delete(value)
  end

  def delete_at(index)
    @tasks.delete(@items[index])
    @items.delete_at(index)
  end

  def remove_completed
    to_remove = []
    @items.each do |item|
      to_remove << item if @tasks[item] == true
    end
    to_remove.each do |item|
      self.delete(item)
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
      while !@items.empty?
        items << @items.pop
      end
      @items = items
    else
      tmp = @items[first]
      @items[first] = @items[second]
      @items[second] = tmp
    end
  end

  def sort
    @items.sort!()
  end

  def print
    @items.each do |item|
      if @tasks[item] == true
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
