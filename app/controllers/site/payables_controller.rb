class Site::PayablesController < ApplicationController
  layout "site"
  before_action :authenticate_user!
  before_action :set_payable, only: [:edit, :update, :destroy]
  before_action :set_suppliers, only: [:new, :create, :edit, :update]
  before_action :set_categories, only: [:index, :new, :create, :edit, :update]

  def index
    @payables = Payable.where("company_id = ?", current_user.company_id).includes(:supplier).page params[:page]
  end

  def new
    @payable = Payable.new(due_date: Date.today, amount_cents: 0)
  end

  def create
    @payable = Payable.new(payable_params)
    @payable.company_id = current_user.company_id
    
    if @payable.save
       redirect_to site_payables_path, notice: "Título a Pagar salvo com sucesso!"
    else
      render :new
    end
  end

  def edit   
  end

  def update
    if @payable.update(payable_params)
      redirect_to site_payables_path, notice: "Título a Pagar alterado com sucesso!"
    else
      render :edit
    end
  end

  private

  def set_payable
    @payable = Payable.find(params[:id])
  end

  def payable_params
    params.require(:payable).permit(:id, :company_id, :supplier_id, :due_date, :amount, :description,
      :receivable_category_id, :status)
  end  

  def set_suppliers
    @suppliers = Supplier.where("company_id = ?", current_user.company_id)
  end

  def set_categories
    @categories = ReceivableCategory.where("company_id = ?", current_user.company_id)
  end
end
