class ProfessionalReservation < ActiveRecord::Base
  belongs_to :company
  belongs_to :user

  scope :company, ->(company) {where("company_id = ?", company)}
  scope :user, ->(user) {where("user_id = ?", user)}
end
