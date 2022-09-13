class Publication < ApplicationRecord
    CONTACT_EMAIL = "publisherbot@example.com"

    has_many :broadcasts, dependent: :destroy
    after_create :create_supporting_conversation
    def create_supporting_conversation
        recipients      = self.initial_recipient
        subject         = self.name
        sender          = initial_recipient
        convo_title     =  "start_of_publication"

        receipt         = sender.send_message(recipients, convo_title, subject)
        # conversation  = reciept.notification.conversation
        
    end

    def current_contact
        Contact.find_by_email(self.email)
        current_contact = Contact.create_or_find_by(email: self.email, name: self.name)

    end

    def initial_recipient
        test_recipient = Contact.create_or_find_by(email: "test_recipient@example.com", name: "test_recipient bot")
    end

    def _find_recipeints_for_group(role)
        return unless Contact.roles.include? role
        recipients = Contact.send(role)
    end

end
