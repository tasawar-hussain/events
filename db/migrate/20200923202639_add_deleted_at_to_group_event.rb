class AddDeletedAtToGroupEvent < ActiveRecord::Migration[6.0]
  def change
    add_column :group_events, :deleted_at, :datetime
    add_index :group_events, :deleted_at
  end
end
