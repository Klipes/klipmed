class Site::ProfessionalsController < ApplicationController
  layout "site"
  before_action :authenticate_user!
  before_action :set_professional, only: [:edit, :update, :destroy]
  before_action :load_covenants, only: [:new, :edit]

  def index
    @professionals = Professional.where("company_id = ?", current_user.company_id).page params[:page]
    authorize @professionals
  end

  def new
    @professional = Professional.new
  end

  def create
    @professional = Professional.new(professional_params)
    @professional.company_id = current_user.company_id
    
    if @professional.save
       redirect_to site_professionals_path, notice: "Profissional salvo com sucesso!"
    else
      render :new
    end
  end

  def edit
  end
  
  def update
    if @professional.update(professional_params)
      redirect_to site_professionals_path, notice: "Profissional alterado com sucesso!"
    else
      render :edit
    end
  end

  private

  def set_professional
    @professional = Professional.find(params[:id])
  end

  def load_covenants
    @covenants = Covenant.where("company_id = ?", current_user.company_id)  
  end

  def professional_params
    params.require(:professional).permit(:id, :fullname, :email, :phone, :company_id)
  end
end
