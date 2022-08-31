class ChangeBroadcastSendAtToBeDatetime < ActiveRecord::Migration[7.0]
  def change
    change_column :broadcasts, :send_at, :t.datetime
  end
end
