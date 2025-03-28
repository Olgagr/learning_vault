class Resource < ApplicationRecord
  belongs_to :user

  validates :name, presence: true, uniqueness: { scope: :user_id }
  validates :link, presence: true, format: { with: URI::regexp(%w[http https]), message: "must be a valid URL" }
end
