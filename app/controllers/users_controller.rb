class UsersController < ApplicationController
  
  def new                 
    @user=User.new
    @title = "Sign up"
  end                  
  
  def show 
    @user = User.find(params[:id])   
    @title = @user.name
  end  
  
  def create
      @user = User.new(params[:user])
      if @user.save                                  
        flash[:success] = "Welcome to the Sample App!"
        #user_path instead @user, because of rspec
        redirect_to user_path(@user)
      else
        @title = "Sign up"
        render 'new'
      end
    end
end
