class Admin::UsersController < Admin::BaseController
  def index
  end

  def new
    @user = User.new
  end
end
