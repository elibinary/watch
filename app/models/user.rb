class User < ActiveRecord::Base

  include Authentication
  include Authentication::ByPassword
  # attr_accessible :name, :email, :password, :remember_token, :remember_token_expires_at
  
  REMEMBER_ONE_DAY = 1

  validates_presence_of   :email
  validates_length_of     :email,     :within => 6..30
  validates_format_of     :email,
    :with => Authentication.email_regex,
    :message => Authentication.bad_email_message

  # before_save :


  def self.authenticate(email, psword)
    puts "This is self.authenticate"
    return nil if email.blank? || psword.blank?
    u = find_by_email(email)
    return nil if u.blank?
    u.authenticated?(psword)
  end

  def self.generate_password
    secure_digest(psword)
  end

  def refresh_token
    self.remember_token = self.class.make_token
    save( :validate => false )
  end

  # using UTC
  def remember_me_until
    self.remember_token_expires_at = Time.zone.now.advance( :days => REMEMBER_ONE_DAY )
    self.remember_token ||= self.class.make_token
    save( :validate => false )
  end

  def forget_me
    self.remember_token_expires_at = nil
    save( :validate => false )
  end
end
