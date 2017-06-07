class Topic < ApplicationRecord
  has_many :posts, dependent: :destroy

  scope :visible_to, -> (user) { user ? all : publicly_viewable }
  scope :publicly_viewable, -> { where(public: true) }
end
