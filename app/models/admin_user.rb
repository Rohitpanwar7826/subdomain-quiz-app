class AdminUser < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :trackable

  has_many :accounts, class_name: "Account", foreign_key: "admin_user_id"
  
  def confirmed_user
    self.skip_confirmation!
    self.save(validate: false)
  end
end
