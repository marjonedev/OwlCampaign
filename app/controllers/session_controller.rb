class SessionController < ApplicationController
  before_action :set_attempted_user, only: [:create]

  def new
    @redirect_to = params[:redirect_to]
    @user = User.new
  end

  def create
    redirect_url = params[:redirect_to] ? URI.decode(params[:redirect_to]) : root_url
    if @attempted_user&.can_authenticate_with?(params[:user][:password])
      session[:user_id] = @attempted_user.id
      redirect_to redirect_url, id: @attempted_user.id
    else
      @user = User.new
      flash.now[:danger] = "Username or password is invalid."
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Logged out!"
  end

  private
    def set_attempted_user
      @attempted_user = nil
      if params[:user][:username].match(/\A[\w.+-]+@\w+\.\w+\z/)
        @attempted_user = (User.where(email_address: params[:user][:username]).size==1) ? User.find_by(email_address: params[:user][:username]) : nil
      else
        @attempted_user = User.find_by(username: params[:user][:username])
      end
    end
end
