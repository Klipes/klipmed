class Schedule < ActiveRecord::Base
  belongs_to :company
  belongs_to :professional
  belongs_to :customer
end
