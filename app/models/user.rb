class User < ActiveRecord::Base
  has_secure_password
  has_many :bg_measurements
  validates :email, :presence => true
  validates :email, :uniqueness => true
  before_create do |r|
    r.email = r.email.downcase
  end
end
