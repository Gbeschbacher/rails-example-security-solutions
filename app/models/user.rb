class User < ActiveRecord::Base
  has_secure_password
  has_many :articles

  attr_accessible :name, :email, :password, :homepage, :is_admin

  validates :name, :email, :password, :presence => true
  validates :email, :format =>  { :with => /@.+\./, :message => "E-Mail should contain @ and at least one dot" }

  def to_s
    name
  end

  def admin?
    is_admin
  end

  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password == password
      user
    else
      nil
    end
  end
end
