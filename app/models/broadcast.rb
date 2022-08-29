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


end
