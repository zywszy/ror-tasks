require_relative 'spec_helper'
require_relative '../lib/todo_list'
require_relative '../lib/exceptions'

describe TodoList do
  subject(:list)            { TodoList.new(db: database, social_network: social_network) }
  let(:database)            { stub }
  let(:item)                { Struct.new(:title,:description).new(title,description) }
  let(:title)               { "Shopping" }
  let(:description)         { "Go to the shop and buy toilet paper and toothbrush" }
  let(:status)              { false }
  let(:social_network)      { stub }

  it "should raise an exception if the database layer is not provided" do
    expect{ TodoList.new(db: nil) }.to raise_error(IllegalArgument)
  end

  it "should be empty if there are no items in the DB" do
    stub(database).items_count { 0 }
    list.should be_empty
  end

  it "should not be empty if there are some items in the DB" do
    stub(database).items_count { 1 }
    list.should_not be_empty
  end

  it "should return its size" do
    stub(database).items_count { 6 }

    list.size.should == 6
  end

  it "should persist the added item" do
    stub(database).items_count { 1 }
    mock(database).add_todo_item(item) { true }
    mock(database).get_todo_item(0) { item }
    mock(social_network).spam(item[:title] + " added!") {true}

    list << item
    list.first.should == item
  end

  it "should persist the state of the item" do
    mock(database).get_todo_item(0) { item }
    mock(database).completed_item?(0) { false }
    mock(database).complete_todo_item(0,true) { true }
    mock(database).get_todo_item(0) { item }
    mock(database).completed_item?(0) { true }
    mock(database).complete_todo_item(0,false) { true }
    mock(social_network).spam(item[:title] + " added!") {true}

    list.toggle_state(0)
    list.toggle_state(0)    
  end

  it "should notify social network if the item state is being changed to TRUE" do
    mock(database).get_todo_item(0) { item }
    mock(database).completed_item?(0) { false }
    mock(database).complete_todo_item(0,true) { true }
    mock(social_network).spam(item[:title] + " added!") {true}

    list.toggle_state(0)
  end

  it "should raise exception when changing item's state, if the item is nil" do
    expect{ list.toggle_state(1) }.to raise_error(Exception)
  end

  it "should fetch the first item from the DB" do
    stub(database).items_count { 1 }
    mock(database).get_todo_item(0) { item }
    list.first.should == item

    mock(database).get_todo_item(0) { nil }
    list.first.should == nil
  end

  it "should fetch the last item for the DB" do
    stub(database).items_count { 6 }

    mock(database).get_todo_item(5) { item }
    list.last.should == item

    mock(database).get_todo_item(5) { nil }
    list.last.should == nil
  end

  context "with empty title of the item" do
    let(:title)   { "" }

    it "should not add the item to the DB" do
      dont_allow(database).add_todo_item(item)
      list << item
    end  
  end

  context "with nil item" do
    let(:item)    { nil }
    
    it "should not add the item if it's nil" do
      dont_allow(database).add_todo_item(item)
      list << item 
    end
    
    it "should raise exception when changing item state, if the item is nil" do
      mock(database).get_todo_item(0) { item }
      expect{ list.toggle_state(0) }.to raise_error(Exception)
    end
    
  end

  context "with too short item title" do
    let(:title)    { "Do" }
    
    it "should not add the item if it's nil" do
      dont_allow(database).add_todo_item(item)
      list << item 
    end
  end

  context "with too long item title" do
    let(:title)    { "01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789" }
    
    it "should cut the title if it's size is longer than 255" do
#      IMPLEMENT!

    end
  end

  context "with empty item describtion" do
    let(:describtion)   { "" }

    it "should persist an item with empty describtion" do
      stub(database).items_count { 1 }
      mock(database).add_todo_item(item) { true }
      mock(database).get_todo_item(0) { item }
      stub(social_network).spam {true}

      list << item
      list.first.should == item
    end

  end

  context "with nil social network" do
    let(:social_network)    { nil }

    it "doesn't spam social network when item is being added to list if social network is nil" do
      stub(database).items_count { 1 }
      mock(database).add_todo_item(item) { true }

      dont_allow(social_network).spam(item[:title] + " added!")
      list << item
    end
  end

  context "with provided social network" do

    it "spams social network when item is being added to list if social network is provided" do
      stub(database).items_count { 1 }
      mock(database).add_todo_item(item) { true }
      mock(social_network).spam(item[:title] + " added!") {true}

      list << item
      #it should be enough - mock determines, if this test passes or not - if spam method is called or not!
    end
  end

end
