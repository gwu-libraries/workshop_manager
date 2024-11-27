class Facilitator < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable
  has_many :workshop_facilitators
  has_many :workshops, through: :workshop_facilitators

  def is_admin?
    self.is_admin
  end
end
