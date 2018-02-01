class Supplier < ActiveRecord::Base
  belongs_to :company
  has_one :supplier_address
  has_many :payables

  validates :supplier_name, presence: true
  validates :phone, presence: true 
  
  accepts_nested_attributes_for :supplier_address
end
