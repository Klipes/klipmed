class Site::CustomersController < ApplicationController
  layout "site"
  before_action :authenticate_user!
  before_action :set_customer, only: [:edit, :update, :destroy]

  def index
    respond_to do |format|
      format.html do
        @customers = Customer.where("company_id = ?", current_user.company_id).order(:fullname).page params[:page]
      end

      format.js do
        @customers = Customer.where("company_id = ? AND (fullname LIKE ?)", current_user.company_id, "%#{params[:search_text]}%").order(:fullname).page params[:page]                
      end

      format.json do
        @customers = Customer.where("company_id = ? AND (fullname LIKE ? OR phone LIKE ?)", current_user.company_id, "%#{params[:q][:term]}%", "%#{params[:q][:term]}%").order(:fullname)
      end
    end
    authorize @customers
  end

  def new
    @customer = Customer.new
    @customer.build_customer_address    
  end

  def create
    @customer = Customer.new(customer_params)
    @customer.company_id = current_user.company_id
    
    if @customer.save
       redirect_to site_customers_path, notice: "Paciente salvo com sucesso!"
    else
      render :new
    end
  end

  def update
    if @customer.update(customer_params)
      redirect_to site_customers_path, notice: "Paciente alterado com sucesso!"
    else
      render :edit
    end
  end

  def edit
  end

  def destroy
  end

  private

  def set_customer
    @customer = Customer.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(
      :id, 
      :fullname, 
      :email, 
      :phone, 
      :company_id,
       customer_address_attributes:[
         :id, 
         :customer_id, 
         :address1, 
         :address2, 
         :number, 
         :neighborhood, 
         :city, 
         :state, 
         :zip])
  end
end
