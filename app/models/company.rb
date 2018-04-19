class Company < ActiveRecord::Base
  validates :company_name, presence: true  
  validates :trade_name, presence: true
  validates :phone, presence: true

  has_one :company_address
  has_one :company_configuration
  has_many :users
  has_many :customers
  has_many :suppliers
  has_many :receivable_categories
  has_many :payable_categories
  has_many :receivables
  has_many :payables
  has_many :schedules
  has_many :covenants
  has_many :professional_reservations
  has_many :payment_methods

  accepts_nested_attributes_for :company_address
  accepts_nested_attributes_for :company_configuration
  
  enum company_type: {:entity => 0, :legal_entity => 1}
end
