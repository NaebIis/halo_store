class SessionsController < ApplicationController
  before_action :redirect_to_login_page_if_not_logged_in, except: [:new, :create]

  def new
  end

  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      cart = Cart.create(user_id: user.id)
      session[:cart_id] = cart.id
      session[:nickname] = user.nickname

      redirect_to user
    else
      flash[:error] = 'Sorry, please try again'
      redirect_to login_path
    end
  end

  def destroy
    Cart.find_by(user_id: session[:user_id]).destroy
    session[:user_id] = nil
    session[:cart_id] = nil
    session[:total] = nil
    session[:nickname] = nil

    redirect_to login_path
  end
end
