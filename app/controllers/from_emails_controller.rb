class FromEmailsController < ApplicationController
  def index
    @from_emails = current_user.from_emails
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_from_email
    @from_emails = current_user.from_emails.find(params[:id])
  end
end
