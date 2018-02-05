class Schedule < ActiveRecord::Base
  belongs_to :company
  belongs_to :user
  belongs_to :customer
end
