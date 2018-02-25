class Customer < ActiveRecord::Base
  belongs_to :company
  has_one :customer_address
  has_many :receivables
  has_many :schedules

  validates :fullname, presence: true
  validates :phone, presence: true 
  
  accepts_nested_attributes_for :customer_address

  default_scope { where("customers.deleted_at IS NULL") }
  scope :fullname_or_phone, ->(text) { where("fullname LIKE ? OR phone LIKE ?", "%#{text}%", "%#{text}%") }
  scope :company, ->(company) {where("company_id = ?", company)}
end
