class Backoffice::UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]
  before_action :authenticate_admin!
  layout "backoffice"

  def index
    @users = User.includes(:company).all.page params[:page]
  end

  def new
    @user = User.new
    load_companies  
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
       redirect_to backoffice_users_path, notice: "Usuário salvo com sucesso!"
    else
      render :new
    end
  end

  def update
    pass = params[:user][:password]
    pass_confirmation = params[:user][:password_confirmation]

    if pass.blank? && pass_confirmation.blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    if @user.update(user_params)
      redirect_to backoffice_users_path, notice: "Usuário alterado com sucesso!"
    else
      render :edit
    end
  end

  def edit
    load_companies
  end

  def destroy
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:user_id, :email, :password, :password_confirmation, :name, :company_id)
  end

  def load_companies
    @companies = Company.all
  end

end
