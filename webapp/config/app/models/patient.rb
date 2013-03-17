class Patient < ActiveRecord::Base
  attr_accessible :address, :age, :avatar, :first_name, :gender, :health_status, :last_name, :phone, :symptoms

  has_many :associations, :dependent => :restrict
  has_many :users, :through => :associations

  before_save :set_registered_datetime

  validates_presence_of :last_name
  validates_presence_of :first_name
  validates_presence_of :gender
  validates_inclusion_of :gender, :in => ['Male', 'Female']
  validates_presence_of :age
  validates_inclusion_of :age, :in => 1..100
  validates_presence_of :phone
  validates_uniqueness_of :phone
  validates_presence_of :address
  validates_presence_of :health_status
  validates_inclusion_of :health_status, :in => ['Healthy', 'Sub-healthy', 'Ill', 'Passed away']
  validates_presence_of :symptoms
  validates_presence_of :avatar

  def set_registered_datetime
    self.date_registered = DateTime.now
  end
end
