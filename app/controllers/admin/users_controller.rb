class Admin::UsersController < Admin::BaseController
  def index
    @users = User.order(:email)
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

  private

  def get_params
    params.require(:user).permit(:email, :password, :admin)
  end
end
