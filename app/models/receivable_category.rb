class ReceivableCategory < ActiveRecord::Base
  belongs_to :company
  has_many :receivables

  validates :description, presence: true , length: {minimum: 4, maximum: 50}
end
