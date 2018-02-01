class Professional < ActiveRecord::Base
  belongs_to :company
  has_one :professional_address
  has_many :schedules
  has_many :professional_reservations
  has_many :professional_covenants
  has_many :covenants, through: :professional_covenants

  validates :fullname, presence: true
  validates :phone, presence: true 
  
  accepts_nested_attributes_for :professional_address
  accepts_nested_attributes_for :professional_covenants, reject_if: :all_blank, allow_destroy: true
end
