class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, #:registerable,
         :recoverable, :rememberable, :trackable, :validatable
        
  enum role: [:full_access, :schedule_access]
  enum user_type: [:user, :professional]

  belongs_to :company
  has_one :user_address
  has_many :professional_reservations

  has_many :user_covenants
  has_many :covenants, through: :user_covenants

  accepts_nested_attributes_for :user_address
  accepts_nested_attributes_for :user_covenants, reject_if: :all_blank, allow_destroy: true
end
