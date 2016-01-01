class AddAuthorToTickets < ActiveRecord::Migration
  def change
    remove_column :tickets, :author_id
    remove_column :tickets, :author_id_id
    add_column :tickets, :author_id, :integer, index: true
    add_foreign_key :tickets, :users, column: :author_id
  end
end
