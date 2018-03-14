class Schedule < ActiveRecord::Base
  belongs_to :company
  belongs_to :user
  belongs_to :customer

  enum schedule_type: [:initial, :normal, :return] 
  
  scope :company, ->(company) {where("company_id = ?", company)}
  scope :user, ->(user) {where("user_id = ?", user)}
end
