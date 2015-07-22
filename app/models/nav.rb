class Nav < ActiveRecord::Base
  belongs_to :project
  belongs_to :page

  default_scope { where( publish: true )}

  enum nav_type: [:page, :url]
  enum target:   [:_blank, :_self]

  validates_presence_of :nav_type, :target, :title
  validates :page, presence: true, if: :is_page?
  validates :url,  presence: true, if: :is_url?

  before_create :set_order

  def switch_up
    current_order = self.order
    next_order    = self.order + 1

    @next = Nav.unscoped.find_by_order(current_order)
    @old  = Nav.unscoped.find_by_order(next_order)
    @old.update(order: current_order)
    @next.update(order: next_order)
  end

  def switch_down
    current_order = self.order
    next_order    = self.order - 1

    @next = Nav.unscoped.find_by_order(current_order)
    @old  = Nav.unscoped.find_by_order(next_order)
    @old.update(order: current_order)
    @next.update(order: next_order)
  end

  private

  def set_order
    self.order = project.navs.unscoped.order(:order).last.order + 1 if project.navs.count > 0
  end

  def is_page?
    self.page?
  end

  def is_url?
    self.url?
  end
end
