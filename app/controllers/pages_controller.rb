class PagesController < ApplicationController
  def home
    if logged_in?
      redirect_to dashboard_url
    end
  end

  def dashboard

  end

  def forgot_password
  end
end
