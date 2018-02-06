class Site::SchedulesController < ApplicationController
  layout "site"
  before_action :authenticate_user!
  before_action :load_users, only:[:index, :new, :edit]
  
  before_action :load_customers, only:[:new, :edit]
  before_action :set_schedule, only: [:edit, :update]

  def index
    _company_id = current_user.company_id

    respond_to do |format|
      format.html
      format.json do
        @schedules =  Schedule.select(:id, :title, :start, :end, :user_id, :customer_id, '0 AS editable' )
                              .includes(:customer).where("company_id = ? and user_id = ?", _company_id, params['user_id']) 
                              .where(start: params[:start]..params[:end]) 

        @reservations = ProfessionalReservation.select(:id, :title, :start, :end, :user_id, '0 AS customer_id', '1 AS editable')
                                               .where("company_id = ? and user_id = ?", _company_id, params['user_id']) 
                                              .where(start: params[:start]..params[:end])    
        
        @schedules = @schedules + @reservations
      end
    end
  end
  
  def new
    @schedule = Schedule.new
    @schedule.start = DateTime.now.beginning_of_hour()
    @schedule.end = DateTime.now
  end

  def create
    @schedule = Schedule.new
    @schedule.company_id      = current_user.company_id
    @schedule.user_id         = params[:schedule][:user_id]
    @schedule.covenant_id     = params[:schedule][:covenant_id]
    @schedule.customer_id     = params[:schedule][:customer_id].to_i
    @schedule.title           = "#{Customer.find(params[:schedule][:customer_id]).fullname} - #{Covenant.find_by(company_id: current_user.company_id, id: params[:schedule][:covenant_id]).description}"
    @schedule.start           = DateTime.parse("#{params[:schedule][:start]} #{params[:schedule][:end]}").strftime("%Y-%m-%dT%H:%M:%S")
    @schedule.end             = @schedule.start + 30.minutes 

    if !@schedule.save
      render :new
    end
  end

  def edit
  end

  def update
    @schedule.user_id = params[:schedule][:user_id]
    @schedule.start = DateTime.parse("#{params[:schedule][:start]} #{params[:schedule][:end]}").strftime("%Y-%m-%dT%H:%M:%S")
    if !params[:schedule][:resize]
      @schedule.end = @schedule.start + 30.minutes
    else
      @schedule.end = DateTime.parse("#{params[:schedule][:end]} #{params[:schedule][:end]}").strftime("%Y-%m-%dT%H:%M:%S")
    end

    if !@schedule.save
      render :edit
    end    
  end

  private
    def load_customers
      @customers = Customer.where("company_id = ?", current_user.company_id)
    end  

    def load_users 
      @users = User.where("company_id = ? AND user_type = ?", current_user.company_id, User.user_types[:professional])
    end

    def set_schedule
      @schedule = Schedule.find(params[:id])
    end
    
    def schedule_params
      params.require(:schedule).permit(:id, :company_id, :professional_id, :customer_id, :covenant_id, :user_id, :start, :end)
    end    
end
