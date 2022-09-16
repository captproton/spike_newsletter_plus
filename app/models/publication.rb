class Publication < ApplicationRecord
    CONTACT_EMAIL = "publisherbot@example.com"
    after_create :create_supporting_conversation

    belongs_to :contact

    has_many :broadcasts, dependent: :destroy
    def create_supporting_conversation
        recipients      = self.initial_recipient
        subject         = self.name
        sender          = self.contact
        convo_title     = "Publication initiated: #{self.name}"

        receipt         = sender.send_message(recipients, convo_title, subject)
        # conversation  = reciept.notification.conversation
        
    end

    def current_contact
        Contact.where(email: self.email).first_or_create(email: self.email, name: self.name)
        current_contact = Contact.create_or_find_by(email: self.email, name: self.name)
    end

    def current_conversation
        contact.mailbox.conversations.find_by_subject(name)
    end

    def reply_to_current_conversation(message)
        receipt = contact.reply_to_conversation(current_conversation, message.to_s)
    end

    def publish_current_broadcasts
        broadcasts.ready_to_send.each do |broadcast|
            reply_to_current_conversation(broadcast.content)
            broadcast.status = "published"
            broadcast.save!
        end
    end

    def initial_recipient
        test_recipient = Contact.where(email: "test_recipient@example.com", name: "test_recipient bot").first_or_create
    end

    def _find_recipeints_for_group(role)
        return unless Contact.roles.include? role
        recipients = Contact.send(role)
    end

end
