class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation, :last_name, :first_name, :phone, :address, :usertype

  has_many :associations, :dependent => :restrict
  has_many :patients, :through => :associations

  attr_accessor :password
  before_save :encrypt_password

  validates_presence_of :email
  validates_uniqueness_of :email
  validates_format_of :email, :with => /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/i
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :last_name
  validates_presence_of :first_name
  validates_presence_of :phone
  validates_uniqueness_of :phone
  validates_presence_of :address
  validates_presence_of :usertype
  validates_inclusion_of :usertype, :in => ['Guardian', 'Care taker', 'Doctor']

  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
end
