class Site::ReceivablesController < ApplicationController
  layout "site"
  before_action :authenticate_user!
  before_action :set_receivable, only: [:edit, :update, :destroy]
  before_action :set_customers, only: [:new, :create, :edit, :update]
  before_action :set_categories, only: [:index, :new, :create, :edit, :update]
  before_action :set_payment_methods, only: [:new, :edit]

  def index
    _user = current_user

    respond_to do |format|
      format.html do
        @receivables = Receivable.not_deleted.company(_user.company_id)
        .user(_user.id)
        .includes(:customer)
        .includes(:receivable_category)
        .order(:due_date)
        .page params[:page]
      end

      format.js do 
        @receivables = Receivable.not_deleted.company(current_user.company_id)
        .user(_user.id)
        .includes(:receivable_category)
        .customers(params[:search_text])
        .status(params[:status])
        .order(:due_date)
        .page params[:page]
      end
    end
    authorize @receivables
  end

  def new
    @receivable = Receivable.new(due_date: Date.today, amount_cents: 0)
  end

  def create
    _user = current_user

    @receivable = Receivable.new(receivable_params)
    @receivable.company_id = _user.company_id
    @receivable.user_id = _user.id
    
    if @receivable.save
       redirect_to site_receivables_path, notice: "Título a Receber salvo com sucesso!"
    else
      render :new
    end
  end

  def edit   
  end

  def update
    if @receivable.update(receivable_params)
      redirect_to site_receivables_path, notice: "Título a Receber alterado com sucesso!"
    else
      render :edit
    end
  end

  def destroy
    @receivable.update(deleted_at: DateTime.now)
  end

  private

  def set_receivable
    @receivable = Receivable.find(params[:id])
  end

  def receivable_params
    params.require(:receivable).permit(:id, :company_id, :customer_id, :user_id, :due_date, :amount, :description,
    :receivable_category_id, :status, :installment)
  end  

  def set_customers
    @customers = Customer.not_deleted.company(current_user.company_id)
  end

  def set_categories
    @categories = ReceivableCategory.not_deleted.company(current_user.company_id)
  end

  def set_payment_methods
    @payment_methods = PaymentMethod.not_delete.company(current_user.company_id)
  end
end
