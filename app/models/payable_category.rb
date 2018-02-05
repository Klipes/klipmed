class PayableCategory < ActiveRecord::Base
  belongs_to :company
  has_many :payables

  validates :description, presence: true, length: {minimum: 5, maximum: 50}
end
