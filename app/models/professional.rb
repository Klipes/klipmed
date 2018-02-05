class Professional < ActiveRecord::Base
  belongs_to :company
  has_many :schedules
  has_many :professional_reservations

  validates :fullname, presence: true
  validates :phone, presence: true 
end
