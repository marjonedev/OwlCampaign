class Template < ApplicationRecord
  belongs_to :user
  has_many :campaigns
  after_create :set_admin_default

  def self.duplicate template, user
    tmpl = template.dup
    tmpl.name = template.name + "(1)"
    tmpl.admin_default = false
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
