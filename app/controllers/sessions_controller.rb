class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
    session[:user_id] = user.id
    if user.phone_number
      redirect_to user_path(user), :notice => "Signed in with Uber!"
    else
      redirect_to edit_user(user), :notice => "Please enter phone number to sign in!"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, :notice => "You've been signed out!"
  end
end
