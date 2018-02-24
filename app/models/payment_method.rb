class PaymentMethod < ActiveRecord::Base
  belongs_to :company

  has_many :receivables
  has_many :payables
end
