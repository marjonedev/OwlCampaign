class Template < ApplicationRecord
  belongs_to :user
  has_many :campaigns
  after_create :set_admin_default

  private
  def set_admin_default
    if self.user.admin
      self.update_column(:admin_default, true)
    end
  end
end
