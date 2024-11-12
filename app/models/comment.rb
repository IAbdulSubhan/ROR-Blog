class Comment < ApplicationRecord
  belongs_to :post


  validates :commenter, presence: true
  validates :body, presence: true

  belongs_to :parent, class_name: "Comment", optional: true  # yeh comment ke parent ko reference karta hai
  has_many :children, class_name: 'Comment', foreign_key: 'parent_id', dependent: :destroy


end
