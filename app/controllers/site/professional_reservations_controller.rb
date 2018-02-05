class Site::ProfessionalReservationsController < ApplicationController
  layout "site"
  before_action :authenticate_user!
  before_action :set_reservation, only: [:edit, :update, :destroy]
  before_action :load_professionals, only: [:new, :edit]
  before_action :load_users, only:[:index, :new, :edit]

  def index
    @reservations = ProfessionalReservation.includes(:user)
      .where("company_id = ?", current_user.company_id).page params[:page]
  end

  def new
    @reservation = ProfessionalReservation.new()
    @reservation.start = DateTime.now.beginning_of_hour()
    @reservation.end = DateTime.now
  end
  
  def create
    @reservation = ProfessionalReservation.new()
    @reservation.company_id = current_user.company_id
    @reservation.user_id = params[:user_id]
    @reservation.title = params[:title]
    @reservation.start = DateTime.parse("#{params[:reservation_date]} #{params[:reservation_hour_begin]}").strftime("%Y-%m-%dT%H:%M:%S")
    @reservation.end = DateTime.parse("#{params[:reservation_date]} #{params[:reservation_hour_end]}").strftime("%Y-%m-%dT%H:%M:%S")

    if @reservation.save
      redirect_to site_professional_reservations_path, notice: "Reserva de Horário salva com sucesso!"
   else
     render :new
   end
 end

  def edit
  end

  def update
    @reservation.user_id = params[:user_id]
    @reservation.title = params[:title]
    @reservation.start = DateTime.parse("#{params[:reservation_date]} #{params[:reservation_hour_begin]}").strftime("%Y-%m-%dT%H:%M:%S")
    @reservation.end = DateTime.parse("#{params[:reservation_date]} #{params[:reservation_hour_end]}").strftime("%Y-%m-%dT%H:%M:%S")

    if @reservation.save
      redirect_to site_professional_reservations_path, notice: "Reserva de Horário alterada com sucesso!"
    else
     render :edit
   end
  end

  private
  def set_reservation
    @reservation = ProfessionalReservation.find(params[:id])
  end 

  def load_professionals
    @professionals = Professional.where("company_id = ?", current_user.company_id)
  end

  def load_users 
    @users = User.where("company_id = ? AND user_type = ?", current_user.company_id, User.user_types[:professional])
  end

  def reservation_params
    params.require(:professional_reservation).permit(:id, :company_id, :professional_id, :user_id, 
      :title, :start, :end,:reservation_date, :reservation_hour_begin, :reservation_hour_end)
  end
end
