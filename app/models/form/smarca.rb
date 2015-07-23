class Form::Smarca < ActiveRecord::Base
  has_one :candidate_subscribe, as: :form
  accepts_nested_attributes_for :candidate_subscribe

  validates_presence_of :name, :cpf, :telephone, :teste

  mount_uploader :teste, FileUploader
end
