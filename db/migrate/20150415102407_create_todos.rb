class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.string :content
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :todos, :users
  end
end
