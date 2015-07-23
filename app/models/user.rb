class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :candidate_subscribes
  
  enum privilege: [:candidate, :master, :manager_information, :manager_candidate, :manager_subscribes, :manager_participations]
  
  scope :administrators, -> { where(administrator: true) }
end
