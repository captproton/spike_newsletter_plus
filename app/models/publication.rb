class Publication < ApplicationRecord
    has_many :broadcasts, dependent: :destroy

    def create_supporting_conversation
        recipients = [publ]
        receipt   = current_contact.send_message(recipients, mailboxer_conversation_params[:rich_body], mailboxer_conversation_params[:subject])
        
    end

    def current_contact
        
    end

    def _set_current_contact
        @current_contact = Contact.find_by_email(CONTACT_EMAIL)
    end

    def _find_recipeints_for_group(role)
        return unless Contact.roles.include? role
        recipients = Contact.send(role)
    end

end
