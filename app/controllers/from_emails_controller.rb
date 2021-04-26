class FromEmailsController < ApplicationController
  before_action :set_from_email, only: [:show, :edit, :update, :destroy]
  before_action :require_login

  def index
    @from_emails = current_user.from_emails
  end

  def show
  end

  def new
    @from_email = current_user.from_emails.new
  end

  def edit
  end

  def create
    @from_email = current_user.from_emails.new(from_email_params)

    respond_to do |format|
      if @from_email.save
        format.js { redirect_to from_emails_url }
        format.html { redirect_to @emaillist, notice: 'From email was successfully created.' }
        format.json { render :show, status: :created, location: @from_email }
      else
        format.js {}
        format.html { render :new }
        format.json { render json: @from_email.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      unless @from_email.is_user_default
        if @from_email.update(from_email_params)
          format.html { redirect_to @from_email, notice: 'From email was successfully updated.' }
          format.json { render :show, status: :ok, location: @from_email }
        else
          format.html { render :edit }
          format.json { render json: @from_email.errors, status: :unprocessable_entity }
        end
      else
        format.html { render :edit }
        format.json { render json: @from_email.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @from_email.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'From email was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def set_default
    @from_email.toggle_default

    respond_to do |format|
      format.js { redirect_to @from_email, notice: "From email was set to default" }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_from_email
    @from_emails = current_user.from_emails.find(params[:id])
  end

  def from_email_params
    params.require(:from_email)
          .permit(:email_address, :default)
  end
end
