class Contact < ApplicationRecord
  # mailboxer messaging setup
  acts_as_messageable
  def mailboxer_email(object)
    return email
  end

  def mailboxer_name
    self.name
  end

  scope :subscribers, -> { where(role: 'subscriber') }
  scope :generic, -> { where(role: 'generic') }
  
 # set user role
  enum role: %i[generic subscriber]
  after_initialize :set_default_role, if: :new_record?

    def set_default_role
    self.role ||= :subscriber
  end

end
