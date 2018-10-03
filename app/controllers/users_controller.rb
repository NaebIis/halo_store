class UsersController < ApplicationController
    def show
        @user = User.find(params[:id])
        if session[:user_id] == params[:id].to_i
          @current_user = @user
        end
      end
    
      def new
      end
    
      def create
        user = User.new(user_params)
        Cart.create(user_id: user.id)
        if user.valid?
          user.save
          session[:user_id] = user.id
          redirect_to user
        else
          flash[:error] = 'Passwords dont match'
          redirect_to new_user_path
        end
      end
    
      private
    
      def user_params
        params.require(:user).permit(:username, :password, :password_confirmation, :secret)
      end
end
