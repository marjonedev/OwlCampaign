class EmaillistsController < ApplicationController
  before_action :set_emaillist, only: [:show, :edit, :update, :destroy, :add_contact, :set_default]
  before_action :require_login

  # GET /emaillists
  # GET /emaillists.json
  def index
    @emaillists = current_user.emaillists
  end

  # GET /emaillists/1
  # GET /emaillists/1.json
  def show
    @contacts = @emaillist.contacts
  end

  # GET /emaillists/new
  def new
    @emaillist = current_user.emaillists.new
  end

  # GET /emaillists/1/edit
  def edit
  end

  # POST /emaillists
  # POST /emaillists.json
  def create
    @emaillist = current_user.emaillists.new(emaillist_params)

    respond_to do |format|
      if @emaillist.save
        format.js { redirect_to emaillists_url }
        format.html { redirect_to @emaillist, notice: 'Email List was successfully created.' }
        format.json { render :show, status: :created, location: @emaillist }
      else
        format.js {}
        format.html { render :new }
        format.json { render json: @emaillist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /emaillists/1
  # PATCH/PUT /emaillists/1.json
  def update
    respond_to do |format|
      if @emaillist.update(emaillist_params)
        format.html { redirect_to @emaillist, notice: 'Email List was successfully updated.' }
        format.json { render :show, status: :ok, location: @emaillist }
      else
        format.html { render :edit }
        format.json { render json: @emaillist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /emaillists/1
  # DELETE /emaillists/1.json
  def destroy
    @emaillist.destroy
    respond_to do |format|
      if @emaillist.default
        @contacts = @emaillist.contacts
        format.html { render :show }
      else
        format.html { redirect_to emaillists_url }
      end
      format.json { render json: @emaillist.errors, status: :unprocessable_entity }
    end
  end

  def add_contact
    respond_to do |format|
      format.js {}
    end
  end

  def set_default

    @emaillist.toggle_default

    respond_to do |format|
      format.js { redirect_to @emaillist, notice: "Email list was set to default" }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_emaillist
    @emaillist = current_user.emaillists.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def emaillist_params
    params.require(:emaillist)
        .permit(:name)
  end
end
