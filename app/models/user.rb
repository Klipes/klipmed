class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, #:registerable,
         :recoverable, :rememberable, :trackable, :validatable
        
  enum role: [:full_access, :schedule_access]
  enum user_type: [:user, :professional]

  belongs_to :company
  has_one :user_address
  has_one :user_configuration
  has_many :professional_reservations

  has_many :user_covenants
  has_many :covenants, through: :user_covenants

  accepts_nested_attributes_for :user_address
  accepts_nested_attributes_for :user_configuration
  accepts_nested_attributes_for :user_covenants, reject_if: :all_blank, allow_destroy: true

  scope :not_deleted, -> { where("users.deleted_at IS NULL") }
  scope :company, ->(company) { where("company_id = ?", company) } 
  scope :user_type, ->(user_type) {where("user_type = ?", user_type)}

  def workDays
    _result = Array.new
    _workDays = Array.new
    _workHours = Array.new
    _user_configuration = UserConfiguration.find(self.id)

    if !_user_configuration.sunday_schedule?
      _workDays.push(0)
    end
    if !_user_configuration.monday_schedule?
      _workDays.push(1)
    end
    if !_user_configuration.tuesday_schedule?
      _workDays.push(2)
    end
    if !_user_configuration.wednesday_schedule?
      _workDays.push(3)
    end
    if !_user_configuration.thursday_schedule?
      _workDays.push(4)
    end
    if !_user_configuration.friday_schedule?
      _workDays.push(5)
    end 
    if !_user_configuration.saturday_schedule?
      _workDays.push(6)
    end   
    
    _workHours.push(_user_configuration.start_hour.strftime("%H:%M"))
    _workHours.push(_user_configuration.end_hour.strftime("%H:%M"))

    _result.push(_workDays)
    _result.push(_workHours)

    return _result
  end
end
