class Page < ActiveRecord::Base
  belongs_to :project

  extend FriendlyId

  friendly_id :title, use: :slugged

  validates_presence_of :title, :content

  default_scope { where(publish: true)}
end
