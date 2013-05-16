class CreateTodoItem < ActiveRecord::Migration
  def change
    create_table :todo_item do |t|
      t.string :title
      t.text :describtion
      t.datetime :date_due
      t.integer :todo_list_id
    end
  end
end
