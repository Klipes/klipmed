class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, #:registerable,
         :recoverable, :rememberable, :trackable, :validatable
        
  enum role: [:full_access, :schedule_access]
  enum user_type: [:user, :professional]

  belongs_to :company
end
