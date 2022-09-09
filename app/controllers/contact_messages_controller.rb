class ContactMessagesController < ApplicationController
  before_action :set_current_contact
  before_action :set_conversation
  CONTACT_EMAIL = "publisherbot@example.com"

  def create
    @current_contact.reply_to_conversation(
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
    redirect_to contact_conversation_path(@conversation)
  end

  private

  def set_current_contact
    # @current_contact = Contact.find_by(email: CONTACT_EMAIL)
    @current_contact = Contact.find_by(email: CONTACT_EMAIL)
  end

  def set_conversation
    @conversation = @current_contact.mailbox.conversations.find(message_params[:contact_conversation_id])
  end
  # Only allow a list of trusted parameters through.
  def message_params
    params.require(:mailboxer_message).permit(:body, :rich_body, :attachment, :contact_conversation_id, contact_conversation: [:id])
  end
end
