class BroadcastsController < ApplicationController
  before_action :set_broadcast, only: %i[ show edit update destroy ]
  before_action :get_publication, only: %i[ create ]

  # GET /broadcasts or /broadcasts.json
  def index
    @broadcasts = Broadcast.all
    @broadcast = Broadcast.new
  end

  # GET /broadcasts/1 or /broadcasts/1.json
  def show
  end

  # GET /broadcasts/new
  def new
    @broadcast = Broadcast.new
  end

  # GET /broadcasts/1/edit
  def edit
  end

  # POST /broadcasts or /broadcasts.json
  def create
    @broadcast = @publication.broadcasts.new(broadcast_params)

    respond_to do |format|
      if @broadcast.save
        format.html { redirect_to broadcast_broadcast_part_path(@broadcast,'assign_settings'), notice: "Broadcast was successfully created." }
        format.json { render :show, status: :created, location: @broadcast }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @broadcast.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /broadcasts/1 or /broadcasts/1.json
  def update
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

    respond_to do |format|
      if @broadcast.update(new_params)
        format.html { redirect_to broadcast_url(@broadcast), notice: "Broadcast was successfully updated." }
        format.json { render :show, status: :ok, location: @broadcast }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @broadcast.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /broadcasts/1 or /broadcasts/1.json
  def destroy
    @broadcast.destroy

    respond_to do |format|
      format.html { redirect_to broadcasts_url, notice: "Broadcast was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_broadcast
      @broadcast = Broadcast.find(params[:id])
    end

    def get_publication
      @publication = Publication.find(params[:publication_id])
    end

    # Only allow a list of trusted parameters through.
    def broadcast_params
      params.require(:broadcast)
            .permit(:name, 
                    :subject, 
                    :preview, 
                    :sender_name, 
                    :sender_email, 
                    :recipients_group,
                    :content,
                    :send_at, 
                    :initialized, 
                    :status,
                    :publication_id)
    end
end
