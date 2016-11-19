class Micropost < ApplicationRecord
  belongs_to :user
  has_one :location, dependent: :destroy
  default_scope -> { order(created_at: :desc) }
  mount_base64_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, length: { maximum: 140 }
  validate  :picture_size
  validate  :picture_present
  
  WillPaginate.per_page = 10
  private

    # Validates the size of an uploaded picture.
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
    
    def picture_present
      if picture.url == nil
        errors.add(:picture, "not selected!")
      end
    end
    
    
end
