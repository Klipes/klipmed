class Supplier < ActiveRecord::Base
  belongs_to :company
  has_one :supplier_address
  has_many :payables

  validates :supplier_name, presence: true
  validates :phone, presence: true 
  
  accepts_nested_attributes_for :supplier_address

  enum supplier_type: {:entity => 0, :legal_entity => 1}

  scope :not_deleted, -> { where("suppliers.deleted_at IS NULL") }
  scope :fullname_or_phone, ->(text) { where("trade_name LIKE ? OR phone LIKE ?", "%#{text}%", "%#{text}%") }
  scope :company, ->(company) {where("company_id = ?", company)}
end
