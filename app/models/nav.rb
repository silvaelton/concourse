class Nav < ActiveRecord::Base
  belongs_to :project
  belongs_to :page

end
