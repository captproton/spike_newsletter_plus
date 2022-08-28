module FormSteps
  # http://api.rubyonrails.org/classes/Module.html#method-i-mattr_accessor
  mattr_accessor :form_steps do
    %i(sign_up set_name set_address find_users)
  end
end

class User < ApplicationRecord
  # include FormSteps

    # Class level accessor http://apidock.com/rails/Class/cattr_accessor
  cattr_accessor :form_steps do
    %w[sign_up set_name set_address find_users]
  end
  # Instance level accessor http://apidock.com/ruby/Module/attr_accessor
  attr_accessor :form_step

  def form_step
    @form_step ||= 'sign_up'
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :omniauthable

  has_one_attached :avatar
  has_person_name
  has_noticed_notifications

  has_many :notifications, as: :recipient, dependent: :destroy
  has_many :services

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :notifications, as: :recipient, dependent: :destroy

  has_one :address, dependent: :destroy, inverse_of: :user, autosave: true
  accepts_nested_attributes_for :address, allow_destroy: true

  # progressive validations for wicked
  with_options if: -> { required_for_step?('set_name') } do |step|
    step.validates :first_name, presence: true
    step.validates :last_name, presence: true
  end  

  validates_associated :address, if: -> { required_for_step?('set_address') }

  # set user role
  enum role: %i[user admin]
  after_initialize :set_default_role, if: :new_record?


  def required_for_step?(step)
    # All fields are reqired if no form step is present
    return true if form_step.nil?

    # All fields from previous step are required if the
    # step parameter appears before or we are on the current step
    return true if form_steps.index(step.to_s).to_i <= form_steps.index(form_step.to_s).to_i
  end

  private

  def set_default_role
    self.role ||= :user
  end
    
end
