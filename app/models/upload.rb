class Upload < ActiveRecord::Base
  attr_accessible :name, :attachment
  belongs_to :course, :class_name => "Course", :foreign_key => "course_id"
  mount_uploader :attachment, AttachmentUploader # Tells rails to use this uploader for this model.
  validates :name, presence: true # Make sure the owner's name is present.
end
