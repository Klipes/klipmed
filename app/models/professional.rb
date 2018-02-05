class Professional < ActiveRecord::Base
  belongs_to :company
  has_one :professional_address
  has_many :schedules
  has_many :professional_reservations

  validates :fullname, presence: true
  validates :phone, presence: true 
  
  accepts_nested_attributes_for :professional_address
end
