class BroadcastPartsController < ApplicationController
  before_action :set_broadcast
  include Wicked::Wizard    
  # Asterisk means variable number of arguments
  steps(*Broadcast.new.form_steps)

  def show
    @broadcast = Broadcast.find(params[:broadcast_id])
    @form_steps_links = Broadcast.new.form_steps.drop(1)

    case step
    when 'initialize_model'
      skip_step if @broadcast.persisted?
    end
    render_wizard

  end

  def update
    @broadcast = Broadcast.find(params[:broadcast_id])
    @form_steps_links = Broadcast.new.form_steps.drop(1)

    case step
    when 'initialize_model'
      skip_step if @broadcast.persisted?
    when 'assign_settings'
        link_classes = "nav-link active"
        aria_hash     = Hash.new
        aria_hash[:current] = 'page'
        if @broadcast.update(broadcast_params)
            render_wizard @broadcast
        else
            render_wizard @broadcast, status: :unprocessable_entity
        end
      
    when 'create_content'
        link_classes = "nav-link active"
        if @broadcast.update(broadcast_params)
            render_wizard @broadcast
        else
            render_wizard @broadcast, status: :unprocessable_entity
        end

    when 'confirm_values'
        link_classes = "nav-link active"
        if @broadcast.update(broadcast_params)
          
            render_wizard @broadcast
        else
            render_wizard @broadcast, status: :unprocessable_entity
        end

    end

  end

  def finish_wizard_path
    broadcast_path(@broadcast)
  end

  private

    def set_broadcast
      @broadcast = Broadcast.find(params[:broadcast_id])
    end

  def broadcast_params
    params  .require(:broadcast)
            .permit(:name, :subject, :preview, :sender_name, :sender_email, :recipients_group, :send_at, :initialized, :content, :status)
  end

end


