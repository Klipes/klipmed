class PaymentMethod < ActiveRecord::Base
  belongs_to :company

  has_many :receivables
  has_many :payables

  default_scope { where("payment_methods.deleted_at IS NULL") }
  scope :company, ->(company) {where("company_id = ?", company)} 
end
