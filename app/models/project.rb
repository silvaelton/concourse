class Project < ActiveRecord::Base
  has_many :pages
  has_many :navs
  has_many :project_subscribes
  has_many :project_participations
  has_many :consults

  extend FriendlyId

  friendly_id :title, use: :slugged

  default_scope { where(publish: true) }

  validates_presence_of :title, :description, :start, :end
  validates_datetime :start, :before => :end 

  mount_uploader :image_header, ImageUploader
  mount_uploader :image_logo, ImageUploader
  mount_uploader :image_footer, ImageUploader
end
