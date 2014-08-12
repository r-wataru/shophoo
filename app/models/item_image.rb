# == Schema Information
#
# Table name: item_images
#
#  id                     :integer          not null, primary key
#  item_id                :integer          not null
#  thumbnail_data         :binary
#  thumbnail_content_type :string(255)
#  data1                  :binary
#  data1_content_type     :string(255)
#  data2                  :binary
#  data2_content_type     :string(255)
#  data3                  :binary
#  data3_content_type     :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#

class ItemImage < ActiveRecord::Base
  belongs_to :item

  attr_reader :uploaded_image1
  attr_reader :uploaded_image2
  attr_reader :uploaded_image3
  attr_reader :uploaded_thumbnail

  validate :check_image1
  validate :check_image2
  validate :check_image3

  IMAGE_TYPES = { "image/jpeg" => "jpg", "image/gif" => "gif", "image/png" => "png" }
  THUMBNAIL_WIDTH = 200
  THUMBNAIL_HEIGHT = 200

  before_save do
    if data1_changed? and !data1.nil?
      thumbnail = Magick::Image.from_blob(data1).first.resize_to_fill(THUMBNAIL_WIDTH, THUMBNAIL_HEIGHT)
      self.thumbnail_data = thumbnail.to_blob
      self.thumbnail_content_type = data1_content_type
    end
  end

  def thumbnail_extension
    IMAGE_TYPES[thumbnail_content_type]
  end

  def extension1
    IMAGE_TYPES[data1_content_type]
  end

  def extension2
    IMAGE_TYPES[data2_content_type]
  end

  def extension3
    IMAGE_TYPES[data3_content_type]
  end

  def uploaded_thumbnail=(thumbnail)
    self.thumbnail_content_type = convert_content_type(thumbnail.content_type)
    self.thumbnail_data = thumbnail.read
    @uploaded_thumbnail = thumbnail
  end

  def uploaded_image1=(image1)
    self.data1_content_type = convert_content_type(image1.content_type)
    self.data1 = image1.read
    @uploaded_image1 = image1
  end

  def uploaded_image2=(image2)
    self.data2_content_type = convert_content_type(image2.content_type)
    self.data2 = image2.read
    @uploaded_image2 = image2
  end

  def uploaded_image3=(image3)
    self.data3_content_type = convert_content_type(image3.content_type)
    self.data3 = image3.read
    @uploaded_image3 = image3
  end

  def check_image1
    if @uploaded_image1
      if data1.size > 5.megabytes
        errors.add(:uploaded_image1, :too_big_image)
      end
      unless IMAGE_TYPES.has_key?(data1_content_type)
        errors.add(:uploaded_image1, :invalid_image)
      end
    else
      if data1.nil?
        errors.add(:uploaded_image1, :blank)
      end
    end
  end

  def check_image2
    if @uploaded_image2
      if data2.size > 5.megabytes
        errors.add(:uploaded_image2, :too_big_image)
      end
      unless IMAGE_TYPES.has_key?(data2_content_type)
        errors.add(:uploaded_image2, :invalid_image)
      end
    end
  end

  def check_image3
    if @uploaded_image3
      if data3.size > 5.megabytes
        errors.add(:uploaded_image3, :too_big_image)
      end
      unless IMAGE_TYPES.has_key?(data3_content_type)
        errors.add(:uploaded_image3, :invalid_image)
      end
    end
  end

  private
  def convert_content_type(ctype)
    ctype = ctype.rstrip.downcase
    case ctype
    when "image/pjpeg" then "image/jpeg"
    when "image/jpg" then "image/jpeg"
    when "image/x-png"  then "image/png"
    else ctype
    end
  end
end
