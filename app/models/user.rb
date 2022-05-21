class User < ApplicationRecord
  has_secure_password

  before_validation :downcase_nickname

  validates :email, presence: true, uniqueness: true,
    format: { with: /([a-z0-9_\.-]+)@([a-z0-9_\.-]+)\.([a-z\.]{2,6})/ }
  validates :nickname, presence: true, uniqueness: true,
    format: { with: /[a-z0-9_]/ }, length: { maximum: 40 }

  has_many :questions, dependent: :delete_all

  def downcase_nickname
    nickname&.downcase!
  end
end
