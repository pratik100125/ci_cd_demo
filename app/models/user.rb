class User < ApplicationRecord
    has_one_attached :profile_picture
    has_many_attached :documents
  
    validate :acceptable_profile_picture, :acceptable_documents
  
    def acceptable_profile_picture
      return unless profile_picture.attached?
  
      unless profile_picture.byte_size <= 1.megabyte
        errors.add(:profile_picture, "is too big (must be less than 1MB)")
      end
  
      acceptable_types = ["image/jpeg", "image/png"]
      unless acceptable_types.include?(profile_picture.content_type)
        errors.add(:profile_picture, "must be a JPEG or PNG")
      end
    end
  
    def acceptable_documents
      documents.each do |doc|
        unless doc.byte_size <= 5.megabytes
          errors.add(:documents, "each file must be less than 5MB")
        end
      end
    end
  end
  