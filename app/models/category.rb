class Category < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :resources

  validates :name, presence: true, uniqueness: { scope: :user_id }
end
