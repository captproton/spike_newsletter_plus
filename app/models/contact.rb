class Contact < ApplicationRecord
  acts_as_messageable

  scope :subscribers, -> { where(role: 'subscriber') }
  scope :generic, -> { where(role: 'generic') }
  
 # set user role
  enum role: %i[generic subscriber]
  after_initialize :set_default_role, if: :new_record?

    def set_default_role
    self.role ||= :subscriber
  end

end
