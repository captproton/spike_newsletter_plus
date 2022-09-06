class MessagesController < ApplicationController
  before_action :set_conversation

  def create
    # receipt = current_user.reply_to_conversation(@conversation, params[:body])
    # redirect_to conversation_path(reciept.conversation) 
    receipt = current_user.reply_to_conversation(
      @conversation,
      message_params[:rich_body],
      nil,
      true,
      true,
      message_params[:attachment]
    )

    puts "********************************"
    puts "convo: #{@conversation.subject}"
    # puts "receipt: #{receipt}"
    puts "********************************"
    redirect_to conversation_path(@conversation)
  end

  private

  def set_conversation
    @conversation = current_user.mailbox.conversations.find(params[:conversation_id])
  end

end
