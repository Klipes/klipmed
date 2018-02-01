class PayableCategory < ActiveRecord::Base
  belongs_to :company
  has_many :payables
end
