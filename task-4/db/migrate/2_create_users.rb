class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :forename
      t.string :surename
      t.string :password
      t.string :email
      t.integer :failed_login_count
    end
  end
end
