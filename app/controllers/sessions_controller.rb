class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_name(params[:session][:name])
    #downcase 
    flash.now[:username] = params[:session][:name] 
    flash.now[:password] = params[:session][:password]

    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_to user
    else
      flash.now[:hint] = "Invalid username or password!"
      render 'new'
    end
  end

  def destroy 
    sign_out
    redirect_to signin_path
  end
end