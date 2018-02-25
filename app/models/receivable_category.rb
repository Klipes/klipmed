class ReceivableCategory < ActiveRecord::Base
  belongs_to :company
  has_many :receivables

  validates :description, presence: true , length: {minimum: 4, maximum: 50}

  default_scope { where("receivable_categories.deleted_at IS NULL") }
  scope :company, ->(company) {where("company_id = ?", company)} 
end
