class Covenant < ActiveRecord::Base
  has_many :user_covenants
  has_many :users, through: :user_covenants

  validates :description, presence: true, length: {minimum: 4, maximum: 50}
end
