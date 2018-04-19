class Backoffice::CompaniesController < ApplicationController
  before_action :set_company, only: [:edit, :update, :destroy]
  before_action :authenticate_admin!
  layout "backoffice"

  def index
    @companies = Company.all.page params[:page]
  end

  def new
    @company = Company.new
    @company.build_company_address   
  end

  def create
    @company = Company.new(company_params)
    
    if @company.save
       redirect_to backoffice_companies_path, notice: "Empresa salva com sucesso!"
    else
      render :new
    end
  end

  def update
    if @company.update(company_params)
      redirect_to backoffice_companies_path, notice: "Empresa alterada com sucesso!"
    else
      render :edit
    end
  end

  def edit
  end

  def destroy
  end

  private
  def set_company
    @company = Company.find(params[:id])
  end

  def company_params
    params.require(:company).permit(:id, :company_name, :trade_name, :email, :phone, :company_type, :identifier,
      company_address_attributes:[:id, :company_id, :address1, :address2, :number, :neighborhood, :city, :state, :zip],
      company_configuration_attributes:[:id, :company_id, :registrations, :receivable, :payable, :schedule])
  end
end
