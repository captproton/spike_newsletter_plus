class BroadcastsController < ApplicationController
  before_action :set_broadcast, only: %i[ show edit update destroy ]

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
    @broadcast = Broadcast.new(broadcast_params)

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
    respond_to do |format|
      if @broadcast.update(broadcast_params)
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

    # Only allow a list of trusted parameters through.
    def broadcast_params
      params.require(:broadcast)
            .permit(:name, :subject, :preview, :sender_name, :sender_email, :recipients_group, :send_at, :initialized)
    end
end
