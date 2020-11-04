class EmaillistsController < ApplicationController
  before_action :set_emaillist, only: [:show, :edit, :update, :destroy]
  before_action :require_login

  # GET /contacts
  # GET /contacts.json
  def index
    @emaillists = current_user.emaillists
  end

  # GET /contacts/1
  # GET /contacts/1.json
  def show
  end

  # GET /contacts/new
  def new
    @emaillist = current_user.emaillists.new
  end

  # GET /contacts/1/edit
  def edit
  end

  # POST /contacts
  # POST /contacts.json
  def create
    @emaillist = current_user.emaillists.new(emaillist_params)

    respond_to do |format|
      if @emaillist.save
        format.html { redirect_to @emaillist, notice: 'Email List was successfully created.' }
        format.json { render :show, status: :created, location: @emaillist }
      else
        format.html { render :new }
        format.json { render json: @emaillist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contacts/1
  # PATCH/PUT /contacts/1.json
  def update
    respond_to do |format|
      if @emaillist.update(contact_params)
        format.html { redirect_to @emaillist, notice: 'Email List was successfully updated.' }
        format.json { render :show, status: :ok, location: @emaillist }
      else
        format.html { render :edit }
        format.json { render json: @emaillist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
    @emaillist.destroy
    respond_to do |format|
      format.html { redirect_to contacts_url, notice: 'Email List was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_emaillist
    @emaillist = current_user.emaillists.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def emaillist_params
    params.require(:contact)
        .permit(:name)
  end
end
