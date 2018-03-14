class Site::SuppliersController < ApplicationController
  layout "site"
  before_action :authenticate_user!
  before_action :set_supplier, only: [:edit, :update, :destroy]

  def index
    respond_to do |format|
      format.html do
        @suppliers = Supplier.not_deleted.company(current_user.company_id).order(:trade_name).page params[:page]
      end

      format.js do
        @suppliers = Supplier.not_deleted.company(current_user.company_id).fullname_or_phone(params[:search_text]).order(:trade_name).page params[:page]                
      end
    end
    authorize @suppliers
  end

  def new
    @supplier = Supplier.new
    @supplier.build_supplier_address 
  end

  def create
    @supplier = Supplier.new(supplier_params)
    @supplier.company_id = current_user.company_id
    
    if @supplier.save
       redirect_to site_suppliers_path, notice: "Fornecedor salvo com sucesso!"
    else
      render :new
    end
  end

  def edit
  end
  
  def update
    if @supplier.update(supplier_params)
      redirect_to site_suppliers_path, notice: "Paciente alterado com sucesso!"
    else
      render :edit
    end
  end

  def destroy
    @supplier.update(deleted_at: DateTime.now)
  end

  private

  def set_supplier
    @supplier = Supplier.find(params[:id])
  end

  def supplier_params
    params.require(:supplier).permit(:id, :supplier_name, :trade_name, :email, :phone, :company_id,
      supplier_address_attributes:[:id, :supplier_id, :address1, :address2, :number, :neighborhood, 
      :city, :state, :zip])
  end
end
