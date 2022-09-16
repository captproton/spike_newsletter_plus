module FormSteps
  # http://api.rubyonrails.org/classes/Module.html#method-i-mattr_accessor
  mattr_accessor :form_steps do
    %w[initialize_model assign_settings create_content confirm_values]
  end
end

class Broadcast < ApplicationRecord
  include FormSteps

  # calculate time difference
require 'dotiw'

include ActionView::Helpers::DateHelper
include ActionView::Helpers::TextHelper
include ActionView::Helpers::NumberHelper

# scopes to find by status
scope :drafts,              -> { where(status: 'd') }
scope :immediate_releases,  -> { where(status: 'ir') }
scope :scheduled_for_later, -> { where(status: 'sl') }
scope :ready_to_publish,    -> { scheduled_for_later.where("send_at < ?", Time.now) }
scope :published,           -> { where(status: 'p') }


  # Instance level accessor http://apidock.com/ruby/Module/attr_accessor
  attr_accessor :form_step

  has_rich_text :content

  belongs_to :publication, optional: true

  def form_step
    @form_step ||= 'initialize_broadcast'
  end

  def send_now
    @send_now ||= false
  end

    # set broadcast types of status
    enum status: {
      d: "draft",
      ir: "immediate_release",
      sl: "scheduled_for_later",
      p: "published"
    }
  after_initialize :set_default_status, if: :new_record?

  # calculate time difference from present
  def scheduled_at
      phrase_of_future_or_past = self.send_at < Time.now ? "ago" : "from now"

    return distance_of_time_in_words(Time.now, 
                                      self.send_at, 
                                      false, 
                                      highest_measures: 2) + " " + "#{phrase_of_future_or_past}"
  end
  
  def self.ready_to_send
    # see notes for 9/14
    ready_to_send = immediate_releases + ready_to_publish
  end

  def publish
    publication.reply_to_current_conversation(content.body)
  end

  private

  def set_default_status
    self.status ||= :d
  end


end
