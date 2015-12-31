class AddAuthorIdToTickets < ActiveRecord::Migration
  def change
    add_reference :tickets, :author_id, index: true
    add_foreign_key :tickets, :users, column: :author_id

  end
end
