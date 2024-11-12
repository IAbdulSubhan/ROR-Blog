class Post < ApplicationRecord
  has_rich_text :body
  has_many :comments, dependent: :destroy
  belongs_to :user
  belongs_to :catagory
  has_one_attached :cover_image

  enum status: {
    draft: 0,
    pending: 1,
    published: 2,
    rejected: 3
  }

  validates :catagory, presence: true
  validates :cover_image, presence: true
  validates :title, presence: true
  validates :overview, presence: true, length: {maximum: 300}
  validates :body, presence: true, length: {minimum: 250}



end
