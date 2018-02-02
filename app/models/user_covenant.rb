class UserCovenant < ActiveRecord::Base
  belongs_to :user
  belongs_to :covenant
end
