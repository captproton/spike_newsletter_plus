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
        broadcasts_to_dispatch = broadcasts.ready_to_send
        return "#{Time.now}:  #{name} has nothing ready to dispatch" if broadcasts_to_dispatch.length == 0
        dispatched_broadcasts = broadcasts_to_dispatch.each.map {|b| 
            {id: b.id, 
            subject: b.subject, 
            publication: {
                id: b.publication.id, 
                name: b.publication.name
                }
            }
        }
        broadcasts_to_dispatch.each do |broadcast|
            reply_to_current_conversation(broadcast.content)
            broadcast.status = "published"
            broadcast.save!
        end
        return dispatched_broadcasts
    end

    def self.dispatch_all
        dispatched_publications = []
        Publication.all.each do |publication|
            dispatch_attempt                = {}
            dispatch_attempt[:time]         = Time.now
            dispatch_attempt[:dispatched]   = publication.publish_current_broadcasts
            dispatched_publications << dispatch_attempt
        end        
        dispatched_publications
    end
    def initial_recipient
        test_recipient = Contact.where(email: "test_recipient@example.com", name: "test_recipient bot").first_or_create
    end

    def _find_recipeints_for_group(role)
        return unless Contact.roles.include? role
        recipients = Contact.send(role)
    end

end
