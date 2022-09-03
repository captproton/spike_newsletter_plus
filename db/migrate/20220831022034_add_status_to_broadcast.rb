class AddStatusToBroadcast < ActiveRecord::Migration[7.0]
  def change
    add_column :broadcasts, :status, :string
  end
end
