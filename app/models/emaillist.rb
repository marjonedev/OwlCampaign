class Emaillist < ApplicationRecord
  belongs_to :user
  has_many :contacts

  before_destroy :prevent_remove_default

  def self.count
    self.contacts.count
  end

  def toggle_default
    self.user.emaillists.where.not(id: self.id).where(default: true).update_all(default: false)
    self.update_attribute(:default, true)
  end

  protected
  def prevent_remove_default
    return unless default
    errors.add(:base, "Cannot remove default email list")
    throw :abort
  end
end
