class FromEmail < ApplicationRecord
  belongs_to :user
  has_many :campaigns, dependent: :restrict_with_error
  before_destroy :stop_destroy
  after_save :check_user_default

  validates_presence_of :email_address
  validates_format_of :email_address, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  before_validation :set_email_token, on: [:create]

  def is_user_default
    self.email_address == self.user.email_address
  end

  def set_email_token
    self.confirm_token = SecureRandom.urlsafe_base64.to_s
  end

  def check_user_default
    if self.default
      self.user.from_emails.where.not(id: self.id).where(default: true).update_all(default: false)
    end
  end

  def stop_destroy
    if self.email_address == self.user.email_address
      self.errors[:base] << "Default user email address cannot be removed"
      return false
    end
  end

  def is_exists
    from = FromEmail.where(email_address: self.email_address, user_id: self.user_id)

    if from.exists?
      true
    end

    false
  end

end
