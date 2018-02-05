class Covenant < ActiveRecord::Base
  has_many :professional_covenants
  has_many :professionals, through: :professional_covenants

  has_many :user_covenants
  has_many :users, through: :user_covenants

  validates :description, presence: true, length: {minimum: 5, maximum: 50}
end
