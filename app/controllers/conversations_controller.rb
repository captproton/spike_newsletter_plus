class ConversationsController < ApplicationController
  before_action :authenticate_user!
  def index
    @conversations = current_user.mailbox.conversations
  end

  def show
    @conversation = current_user.mailbox.conversations.find(params[:id])
    @conversation.mark_as_read(current_user)
    @message = Mailboxer::Message.new
    @thought = Mailboxer::Message.new
  end
end
