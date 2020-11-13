class Template < ApplicationRecord
  belongs_to :user
  has_many :campaigns
  after_create :set_admin_default

  def duplicate user
    tmpl = self.dup
    tmpl.name = self.name + "(1)"
    tmpl.admin_default = false
    tmpl.visible = true
    tmpl.user = user

    tmpl
  end

  private
  def set_admin_default
    if self.user.admin
      self.update_column(:admin_default, true)
    end
  end
end
