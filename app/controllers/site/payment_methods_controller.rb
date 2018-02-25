class Site::PaymentMethodsController < ApplicationController
  layout "site"
  before_action :authenticate_user!
  before_action :set_payment_method, only: [:edit, :update, :destroy]

  def index
    @payment_methods = PaymentMethod.company(current_user.company_id).order(:description).page params[:page]
  end

  def new
    @payment_method = PaymentMethod.new
  end
  
  def create
    @payment_method = PaymentMethod.new(payment_method_params)
    @payment_method.company_id = current_user.company_id
    
    if @payment_method.save
       redirect_to site_payment_method_path, notice: "Forma de Pagamento salva com sucesso!"
    else
      render :new
    end  end

  def edit 
  end

  def update
    if @payment_method.update(payment_method_params)
      redirect_to site_payment_methods_path, notice: "Forma de Pagamento alterada com sucesso!"
    else
      render :edit
    end
  end

  def destroy
    @payment_method.update(deleted_at: DateTime.now)
  end

  def set_payment_method
    @payment_method = PaymentMethod.find(params[:id])
  end

  def payment_method_params
    params.require(:payment_method).permit(:id, :company_id, :description)
  end  
end
