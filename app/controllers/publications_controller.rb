class PublicationsController < ApplicationController
  before_action :set_publication, only: %i[ show edit update destroy ]
  before_action :set_contact, only: %i[ create ]

  # GET /publications or /publications.json
  def index
    @publications = Publication.all
    # @conversation = @publication.contact.mailbox.conversations.find_by_subject(@publication.name)
    # @convo = @publication.contact.mailbox.conversations.find_by_subject(@publication.name)
    # @conversations = @publication.contact.mailbox.conversations
  end

  # GET /publications/1 or /publications/1.json
  def show
    @broadcast = Broadcast.new
  end

  # GET /publications/new
  def new
    @publication = Publication.new
  end

  # GET /publications/1/edit
  def edit
  end

  # POST /publications or /publications.json
  def create
    @contact = Contact.where(email: publication_params[:contact_email])
                      .first_or_create(email: publication_params[:contact_email], name: publication_params[:contact_name], role: "publisher")
    @publication = @contact.publications.create!(name: publication_params[:name])

    respond_to do |format|
      if @publication.save
        format.html { redirect_to publication_url(@publication), notice: "Publication was successfully created." }
        format.json { render :show, status: :created, location: @publication }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @publication.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /publications/1 or /publications/1.json
  def update
    respond_to do |format|
      if @publication.update(publication_params)
        format.html { redirect_to publication_url(@publication), notice: "Publication was successfully updated." }
        format.json { render :show, status: :ok, location: @publication }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @publication.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /publications/1 or /publications/1.json
  def destroy
    @publication.destroy

    respond_to do |format|
      format.html { redirect_to publications_url, notice: "Publication was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_publication
      @publication = Publication.find(params[:id])
    end

    def set_contact
      @contact = Contact.where(email: publication_params[:contact_email], name: publication_params[:contact_name], role: "publisher").first_or_create
    end
    # Only allow a list of trusted parameters through.
    def publication_params
      params.require(:publication).permit(:name, :contact_email, :contact_name)
    end
end
