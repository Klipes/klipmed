class Covenant < ActiveRecord::Base
  has_many :professional_covenants
  has_many :professionals, through: :professional_covenants
end
