class Site::CovenantsController < ApplicationController
  layout "site"
  before_action :authenticate_user!
  before_action :set_covenant, only: [:edit, :update, :destroy]

  def index
    @covenants = Covenant.company(current_user.company_id).order(:description).page params[:page]
  end

  def new
    @covenant = Covenant.new
  end

  def create
    @covenant = Covenant.new(covenant_params)
    @covenant.company_id = current_user.company_id
    
    if @covenant.save
        redirect_to site_covenants_path, notice: "Convênio salvo com sucesso!"
    else
      render :new
    end
  end

  def update
    if @covenant.update(covenant_params)
      redirect_to site_covenants_path, notice: "Convênio alterado com sucesso!"
    else
      render :edit
    end
  end

  def edit
  end

  def destroy
    @covenant.update(deleted_at: DateTime.now)
  end

  private

  def set_covenant
    @covenant = Covenant.find(params[:id])
  end

  def covenant_params
    params.require(:covenant).permit(:id, :description, :company_id)
  end  

end
