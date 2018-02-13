class Schedule < ActiveRecord::Base
  belongs_to :company
  belongs_to :user
  belongs_to :customer

  enum schedule_type: [:initial, :normal, :return]  
end
