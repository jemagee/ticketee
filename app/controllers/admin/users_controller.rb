class Admin::UsersController < Admin::BaseController

  before_action :find_user, only: [:edit, :show, :update, :destroy, :archive]
  def index
    @users = User.excluding_archived.order(:email)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(get_params)
    if @user.save
      flash[:notice] = "User has been created."
      redirect_to admin_users_path
    else
      flash[:alert] = "User has not been created."
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update

    if params[:user][:password].blank?
      params[:user].delete(:password)
    end
    
    if @user.update(get_params)
      flash[:notice] = "User has been updated."
      redirect_to admin_users_path
    else
      flash.now[:alert] = "User has not been updated."
      render "edit"
    end
  end

  def archive

    if @user == current_user
      flash[:notice] = "You can not archive yourself!"
    else
      @user.archive
      flash[:notice] = "User has been archived!"
    end
    redirect_to admin_users_path
  end

  private

  def get_params
    params.require(:user).permit(:email, :password, :admin)
  end

  def find_user
    @user = User.find(params[:id])
  end
end
