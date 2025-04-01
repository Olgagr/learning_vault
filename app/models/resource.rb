class Resource < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :categories

  validates :name, presence: true, uniqueness: { scope: :user_id }
  validates :link, presence: true, format: { with: URI.regexp(%w[http https]), message: "must be a valid URL" }

  enum :resource_type, {
    course: "course",
    book: "book",
    video: "video",
    podcast: "podcast",
    article: "article",
    other: "other"
  }, prefix: true

  enum :progress_status, {
    unstarted: "unstarted",
    in_progress: "in_progress",
    completed: "completed",
    abandoned: "abandoned"
  }, prefix: true
end
