json.extract! broadcast, :id, :name, :subject, :preview, :sender_name, :sender_email, :recipients_group, :send_at, :created_at, :updated_at
json.url broadcast_url(broadcast, format: :json)
