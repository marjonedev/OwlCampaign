class User < ApplicationRecord
  attr_accessor :password

  has_many :emaillist
  has_many :contact
  has_many :template

  validates_presence_of :username
  validates_confirmation_of :password
  validates_presence_of :password, :if => :password_required?
  validates_length_of :password, :within => 8..40, :if => :password_required?
  validates_length_of :username, :within => 5..40
  validates_uniqueness_of :username, :case_sensitive => false
  validates_presence_of :email_address
  validates_format_of :email_address, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates_format_of :username, :with => /\A[a-z][a-z0-9\_]*?\Z/, :message => "must start with a letter and include only letters, numbers, and underscore."
  # validate :address_exist_validator, on: :create

  before_save :encrypt_password
  before_validation :set_initial_content, on: [:create]
  before_validation :lowercase_username

  def set_initial_content
    self.password = self.email_address
    self.username = self.email_address.gsub("@","_").gsub(".","_")
    # set default subscription_id
    # s = Subscription.find_by(name: "Entrepreneur").id
    # self.subscription_id = s
  end

  def lowercase_username
    self.username.downcase!
  end

  def can_authenticate_with?(password)
    self.encrypted_password == User.encrypt(password, self.salt)
  end

  def encrypt(password)
    self.class.encrypt(password, salt)
  end

  def self.encrypt(password,salt)
    Digest::SHA512.hexdigest("--#{salt}---#{password}--")
  end

  def self.authenticate(username, password)
    user = find_by(username: username)
    if user && user.encrypted_password == User.encrypt(password, user.salt)
      user
    else
      nil
    end
  end

  def reset_password!(password)
    # self.reset_password_token = nil
    self.password = password
    save!
  end

  protected
  # before filter
    def encrypt_password
      return if password.blank?
      self.salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}---#{username}--") if new_record?
      self.encrypted_password = encrypt(password)
    end

    def password_required?
      encrypted_password.blank? || !password.blank?
    end

  private
    def generate_token
      SecureRandom.hex(10)
    end

    def address_exist_validator
      # accounts = Emailaccount.where(address: self.email_address)
      #
      # unless accounts.empty?
      #   errors.add(:email_address, "#{self.email_address} is already in use. Please use a different email address.")
      # end
    end
end
