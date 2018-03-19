class Site::PayablesController < ApplicationController
  layout "site"
  before_action :authenticate_user!
  before_action :set_payable, only: [:edit, :update, :destroy]
  before_action :set_suppliers, only: [:new, :create, :edit, :update]
  before_action :set_categories, only: [:index, :new, :create, :edit, :update]
  before_action :set_payment_methods, only: [:new, :edit]

  def index
    _user = current_user

    respond_to do |format|
      format.html do
        @payables = Payable.not_deleted.company(_user.company_id)
          .user(_user.id)
          .includes(:supplier)
          .includes(:payable_category)
          .order(:due_date)
          .page params[:page]
      end

      format.js do
        @payables = Payable.not_deleted.company(_user.company_id)
        .user(_user.id)
        .includes(:payable_category)
        .suppliers(params[:search_text])
        .status(params[:status])
        .order(:due_date)
        .page params[:page]
      end
    end
    authorize @payables
  end

  def new
    @payable = Payable.new(due_date: Date.today, amount_cents: 0)
  end

  def create
    _user = current_user

    @payable = Payable.new(payable_params)
    @payable.company_id = current_user.company_id
    @payable.user_id = _user.id
    
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

  def destroy
    @payable.update(deleted_at: DateTime.now)
  end

  private

  def set_payable
    @payable = Payable.find(params[:id])
  end

  def payable_params
    params.require(:payable).permit(:id, :company_id, :supplier_id, :due_date, :amount, :description,
      :receivable_category_id, :status, :installment)
  end  

  def set_suppliers
    @suppliers = Supplier.not_deleted.company(current_user.company_id)
  end

  def set_categories
    @categories = ReceivableCategory.not_deleted.company(current_user.company_id)
  end

  def set_payment_methods
    @payment_methods = PaymentMethod.not_deleted.company(current_user.company_id)
  end
end
