require_relative 'test_helper'
require_relative '../lib/book'

describe Book do
  include TestHelper

  it "should persist itself" do
    Book.create(:title => "Another title")
    Book.last.title.should == "Another title"
    Book.count.should == 2
  end
  it "should persist itself" do
    book = Book.new()
    book.save!
  end

end
