class SessionsController < ApplicationController

  def new
  end

  def create
    if user = User.authenticate_with_credentials(params[:email], params[:password])

      # Save user id inside browser cookie to keep user logged in during visit
      session[:user_id] = user.id
      redirect_to '/'
    else
    # If user's login doesn't work, redirect to login form.
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end

end
