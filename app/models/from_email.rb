class FromEmail < ApplicationRecord
  belongs_to :user

  validates_presence_of :email_address
  validates_format_of :email_address, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  before_validation :set_email_token, on: [:create]

  def set_email_token
    self.confirm_token = SecureRandom.urlsafe_base64.to_s
  end

end
