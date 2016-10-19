class Image < ActiveRecord::Base
  has_attached_file :girl
  validates_attachment_content_type :girl, content_type: [/\Aimage\/.*\z/,/\Avideo\/.*\z/]
  validates :title, :cat, :res,:girl, presence: true
  belongs_to :user
  ratyrate_rateable "quality", "girl"

end
