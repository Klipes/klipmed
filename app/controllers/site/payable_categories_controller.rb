class Site::PayableCategoriesController < ApplicationController
  layout "site"
  before_action :authenticate_user!
  before_action :set_payable_category, only: [:edit, :update, :destroy]

  def index
    @payable_categories = PayableCategory.where("company_id = ?", current_user.company_id).page params[:page]
  end

  def new
    @payable_category = PayableCategory.new
  end

  def create
    @payable_category = PayableCategory.new(payable_category_params)
    @payable_category.company_id = current_user.company_id
    
    if @payable_category.save
        redirect_to site_payable_categories_path, notice: "Categoria salva com sucesso!"
    else
      render :new
    end
  end

  def update
    if @payable_category.update(payable_category_params)
      redirect_to site_payable_categories_path, notice: "Categoria alterada com sucesso!"
    else
      render :edit
    end
  end

  def edit
  end

  def destroy
  end

  private

  def set_payable_category 
    @payable_category = PayableCategory.find(params[:id])
  end

  def payable_category_params
    params.require(:payable_category).permit(:id, :description, :company_id)
  end  
end
