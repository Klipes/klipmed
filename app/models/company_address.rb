class CompanyAddress < ActiveRecord::Base
  belongs_to :company

  validates :zip, presence: true
end
