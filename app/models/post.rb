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
  validates :overview, presence: true, length: { maximum: 300 }
  validates :body, presence: true, length: { minimum: 250 }



  def self.ransackable_associations(auth_object = nil)
    ["catagory", "comments", "cover_image_attachment", "cover_image_blob", "rich_text_body", "user"]
  end

  # List of attributes that Ransack can search
  def self.ransackable_attributes(auth_object = nil)
    ["body", "catagory_id", "created_at", "id", "id_value", "overview", "status", "title", "updated_at", "user_id"]
  end
end
