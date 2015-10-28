class Article < ActiveRecord::Base
  has_many :comments
  has_many :taggings
  has_many :tags, through: :taggings
  has_attached_file :image
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  def tag_list
    tags.join(', ')
  end

  def tag_list=(tags_string)
    tags = tags_string.split(',').collect { |s| s.strip.downcase }.uniq
    new_or_found_tags = tags.collect { |name| Tag.find_or_create_by(name: name) }
    self.tags = new_or_found_tags
  end
end
