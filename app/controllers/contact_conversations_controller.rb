class ContactConversationsController < ApplicationController
  before_action :set_current_contact, except: %i[ show index ]

  CONTACT_EMAIL = "publisherbot@example.com"
  def index
    publication = Publication.find((params[:publication_id]))
    @current_contact = publication.contact
    @conversations = @current_contact.mailbox.conversations
  end

  def inbox
    @conversations = @current_contact.mailbox.inbox
    render action: :index
  end

  def sent
    @conversations = @current_contact.mailbox.sentbox
    render action: :index
  end

  def trash
    @conversations = @current_contact.mailbox.trash
    render action: :index
  end

  def show
    publication = Publication.find((params[:publication_id]))
    @current_contact = publication.contact

    @conversation = @current_contact.mailbox.conversations.find(params[:id])
    @conversation.mark_as_read(@current_contact)
    @message = Mailboxer::Message.new
  end

  def new
    @conversation = Mailboxer::Conversation.new
    @recipient_groups = Contact.roles.keys
  end

  def create
    recipients = _find_recipeints_for_group(mailboxer_conversation_params[:recipient_group])
    receipt   = @current_contact.send_message(recipients, mailboxer_conversation_params[:rich_body], mailboxer_conversation_params[:subject])
    redirect_to contact_conversations_path

    
  end

  private

  def set_current_contact
    # @current_contact = Contact.find_by_email(CONTACT_EMAIL)
    @current_contact = Contact.find_by_email(CONTACT_EMAIL)
  end

  def _find_recipeints_for_group(role)
    return unless Contact.roles.include? role
    recipients = Contact.send(role)
  end

  # Only allow a list of trusted parameters through.
  def mailboxer_conversation_params
    params.require(:mailboxer_conversation).permit(
    :recipient_group, :rich_body, :attachment, :subject)
  end
  
end
