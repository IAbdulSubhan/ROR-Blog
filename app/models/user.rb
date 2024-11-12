class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one_attached :profile_picture
  validates :profile_picture, presence: true
  has_many :posts 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  before_destroy :ensure_not_admin
  class Error < StandardError
  end

  def username
    return self.email.split("@")[0].capitalize
  end  

  # main yaha sy current user k zariya logined person details nikalna chah rha hu
  def currentuser
    self.email
  end

  private

  def ensure_not_admin
    if admin?
      throw(:abort)
    end
  end
  
end
