class Contact < ApplicationRecord
  belongs_to :user
  belongs_to :emaillist, optional: true
  has_many :emailsends

  validates_presence_of :email
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  # after_create :set_emaillist

  private
  def set_emaillist
    elid = self.user.emaillists.where(default: true).first.id
    self.update_column(:emaillist_id, elid)
  end
end
