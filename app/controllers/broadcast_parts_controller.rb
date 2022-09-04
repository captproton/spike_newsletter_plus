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

        @recipient_count = Contact.send(@broadcast.recipients_group).count

        @now = Time.now
        @future = Time.now.years_since(99)
        # "----------------------------------------------------------------"
        # puts "original params: #{broadcast_params}"
        new_params = broadcast_params
        # puts "new params: #{new_params}"
        # "----------------------------------------------------------------"

        # update the delivery params
        if broadcast_params["status"] == "d"
          new_params = new_params.extract!("status")
          new_params["send_at"] = @future
        elsif new_params["status"] == "ir"
          new_params = broadcast_params.extract!("status")
          new_params["send_at"] = @now
        elsif broadcast_params["status"] == "sl"
          # do not change the params.  Take the user's input as is.
          new_params = broadcast_params
        else
          new_params = new_params.extract!("status")
          new_params["send_at"] = @future
        end

        
        if @broadcast.update(new_params)
          
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
            .permit(:name, 
                    :subject, 
                    :preview, 
                    :sender_name, 
                    :sender_email, 
                    :recipients_group, 
                    :send_at, 
                    :initialized, 
                    :content, 
                    :status, 
                    :publication_id)
  end

end


