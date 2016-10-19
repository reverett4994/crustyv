class Video < ActiveRecord::Base
  has_attached_file :movie
  validates_attachment_content_type :movie, content_type: [/\Aimage\/.*\z/,/\Avideo\/.*\z/]
  validates :title, :cat, :res,:movie, presence: true
  belongs_to :user
  ratyrate_rateable "quality", "girl"
  self.per_page = 6

end
