class Site::UsersController < ApplicationController
  layout "site"
  before_action :authenticate_user!
  before_action :set_user, only: [:edit, :update, :destroy]
  before_action :load_covenants, only: [:new, :edit]

  def index
    if current_user.full_access?
      @users = User.where("company_id = ?", current_user.company_id).all.page params[:page]
    else
      @users = User.where("id = ?", current_user.id).all.page params[:page]
    end
  end

  def new
    @user = User.new
    @user.build_user_address 
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
       redirect_to site_users_path, notice: "Usuário salvo com sucesso!"
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
      redirect_to site_users_path, notice: "Usuário alterado com sucesso!"
    else
      render :edit
    end
  end

  def edit
  end

  def destroy
  end
  
  def configuration
    respond_to do |format|
      format.json do
        @list = [1,3,5].map(&:to_i) 
        puts @list
      end
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(
      :user_id, :email, :password, :password_confirmation, :name, :company_id, :role, :user_type,
      user_address_attributes:[:id, :user_id, :address1, :address2, :number, 
        :neighborhood, :city, :state, :zip],
      user_covenants_attributes:[:id, :covenant_id, :_destroy])
  end

  def load_covenants
    @covenants = Covenant.where("company_id = ?", current_user.company_id)  
  end
end
