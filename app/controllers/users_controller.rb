class UsersController < ApplicationController
  before_filter :authenticate, :only=> [:index,:edit,:update, :destroy]
  before_filter :correct_user, :only=> [:edit,:update]
  before_filter :admin_user, :only => :destroy
  def new                 
    @user=User.new
    @title = "Sign up"
  end                  
  
  def index
    @users=User.paginate(:page => params[:page])
    @title='All users'
  end
  def show       
    @user = User.find(params[:id])           
    @microposts = @user.microposts.paginate(:page => params[:page])
    @title = @user.name
  end  
  
  def create
      @user = User.new(params[:user])
      if @user.save                                  
        flash[:success] = "Welcome to the Sample App!"    
        sign_in @user
        #user_path instead @user, because of rspec
        redirect_to user_path(@user)
      else
        @title = "Sign up"
        render 'new'
      end
  end
  
  def edit
    @title = "Edit user"
  end
  
  def update
    @user=User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success]='Profile updated.'
      redirect_to @user
    else
      @title='Edit user'
      flash[:error]='Wrong parameters.'
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success]='User deleted.'
    redirect_to users_path
  end
  
  private 
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user? @user
    end
    
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
