class User < ActiveRecord::Base
  has_many :articles

  before_save {self.email = email.downcase}

  VALID_EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  validates :username, presence: true,
                        uniqueness: {case_sensitive: false},
                        length: {minimum: 3, maximum: 25}

  validates :email, presence: true,
                    uniqueness: {case_sensitive: false},
                    length: {maximum: 105},
                    format: {with: VALID_EMAIL_REGEX}

  has_secure_password
end
