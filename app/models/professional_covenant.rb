class ProfessionalCovenant < ActiveRecord::Base
  belongs_to :professional
  belongs_to :covenant
end
