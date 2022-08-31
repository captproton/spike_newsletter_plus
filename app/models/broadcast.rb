module FormSteps
  # http://api.rubyonrails.org/classes/Module.html#method-i-mattr_accessor
  mattr_accessor :form_steps do
    %w[initialize_model assign_settings create_content confirm_values]
  end
end

class Broadcast < ApplicationRecord
  include FormSteps

  # Instance level accessor http://apidock.com/ruby/Module/attr_accessor
  attr_accessor :form_step

    has_rich_text :content

  def form_step
    @form_step ||= 'initialize_broadcast'
  end

  def send_now
    @send_now ||= false
  end

    # set user role
    enum status: {
      draft: "D",
      immediate_release: "IR",
      schedule_for_later: "SL",
      published: "P"}
  after_initialize :set_default_status, if: :new_record?

  
  private

  def set_default_status
    self.status ||= :draft
  end


end
