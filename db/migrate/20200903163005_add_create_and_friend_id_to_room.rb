class AddCreateAndFriendIdToRoom < ActiveRecord::Migration[5.2]
  def change
    add_column :rooms, :creator_id, :integer
    add_column :rooms, :friend_id, :integer
    add_index(:rooms, [:creator_id, :friend_id])
  end
end
