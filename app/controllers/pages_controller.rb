class PagesController < ApplicationController
  def home
    if logged_in?
      redirect_to dashboard_url
    end
  end

  def dashboard
    if logged_in?
      @campaigns = current_user.campaigns.where("status != ?", 'incomplete').order("id desc").limit(10)
    else
      redirect_to pages_home_url
    end
  end

  def forgot_password
  end

  def features
  end

  def pricing
  end

  def security
  end

  def guides
  end

  def faqs
  end

  def about
  end

  def privacy
  end

  def terms
  end

  def contact
  end

end
