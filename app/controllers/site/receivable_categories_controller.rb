class Site::ReceivableCategoriesController < ApplicationController
  layout "site"
  before_action :authenticate_user!
  before_action :set_receivable_category, only: [:edit, :update, :destroy]

  def index
    @receivable_categories = ReceivableCategory.where("company_id = ?", current_user.company_id).order(:description).page params[:page]
  end

  def new
    @receivable_category = ReceivableCategory.new
  end

  def create
    @receivable_category = ReceivableCategory.new(receivable_category_params)
    @receivable_category.company_id = current_user.company_id
    
    if @receivable_category.save
       redirect_to site_receivable_categories_path, notice: "Categoria salva com sucesso!"
    else
      render :new
    end
  end

  def update
    if @receivable_category.update(receivable_category_params)
      redirect_to site_receivable_categories_path, notice: "Categoria alterada com sucesso!"
    else
      render :edit
    end
  end

  def edit
  end

  def destroy
  end

  private

  def set_receivable_category 
    @receivable_category = ReceivableCategory.find(params[:id])
  end

  def receivable_category_params
    params.require(:receivable_category).permit(:id, :description, :company_id)
  end  
end
