class User < ActiveRecord::Base
  has_secure_password
  has_many :bg_measurements
  before_create do |r|
    r.email = r.email.downcase
  end
end
