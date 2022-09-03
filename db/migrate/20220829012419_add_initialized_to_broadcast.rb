class AddInitializedToBroadcast < ActiveRecord::Migration[7.0]
  def change
    add_column :broadcasts, :initialized, :boolean
  end
end
