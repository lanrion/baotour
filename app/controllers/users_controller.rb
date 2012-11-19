# encoding: UTF-8
class UsersController < ApplicationController
  before_filter :authenticate_user!
	load_and_authorize_resource :only => [:new,:index,:create,:update,:edit,:show]
  
  def index
    authorize! :index, @user, :message => 'Not authorized as an administrator.'
    @users = User.order("created_at DESC")
    								.paginate(:page => params[:page], :per_page => 25)
  end

  def show
    @user = User.find(params[:id])
    render 'users/edit'
  end

  def new
    @user = User.new
    render 'users/edit'
  end
  
  def edit
    
  end
  
  def create
    u = save()
    if u.show_role =="财务组"
    	redirect_to users_path
    else
    	flash.notice = "用户创建成功，请添加相应管理的酒店"
    	redirect_to edit_user_path(u.id)
    end	
  end
  
  def update
    save()
    redirect_to users_path
  end
  
  def save

    role = params[:user]['group']
    usr = params[:user]
    if usr[:id].empty?
      @user = User.new(usr)
     # @user.new(usr)
    else
      @user = User.find(usr[:id])
      @user.update_attributes(usr)
    end

    if @user.invalid?
      p @user.errors
      render 'users/edit'
      return
    end
    @user.save!
    @user.add_role role
    @user
  end
  
end

