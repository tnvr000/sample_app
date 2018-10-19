class UsersController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update, :destroy]
  before_action :admin_user,     only: :destroy
  after_action :details

  def index
    @users = User.paginate(page: params[:page])
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
      sign_in @user
  		flash[:success] = "Welcome to the Sample App!"
  		redirect_to @user
  	else
  		render 'new'
  	end
  end

  def show
    # binding.pry
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
    respond_to do |format|
      format.html
      format.pdf {render rb: send_this and return}
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile update"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User Deleted"
    redirect_to users_url
  end

  def following
    @title = "following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render "show_follow"
  end

  private
  def user_params
  	params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  # filters
  def correct_user
    @user = User.find(params[:id])
    unless current_user?(@user)
      redirect_to edit_user_path(current_user)
      flash[:warning] = "Please edit your account only"
    end
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

  def details
    puts "request"
    puts "Host      : #{request.host}"
    puts "Domain    : #{request.domain(1)}"
    puts "Format    : #{request.format}"
    puts "Method    : #{request.method}"
    puts "IP        : #{request.remote_ip}"
    puts "URL       : #{request.url}"
    puts "\nResponse"
    puts "Location  : #{response.location}"
    puts "Status    : #{response.status}"
  end

  def send_this
    # send_file("#{Rails.root}/config/routes.rb", filename: "routes.rb", type: "text/ruby")
    File.read("#{Rails.root}/config/routes.rb")
  end

end
