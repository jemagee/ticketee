class AddIndexToAuthorOnTickets < ActiveRecord::Migration
  def change
    add_foreign_key :tickets, :users, columnn: :author_id
  end
end
