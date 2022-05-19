class User < ApplicationRecord
  has_secure_password

  before_save :downcase_nickname

  validates :email, presence: true, uniqueness: true,
    format: { with: /([a-z0-9_\.-]+)@([a-z0-9_\.-]+)\.([a-z\.]{2,6})/, message: "invalid email addres"}
  validates :nickname, presence: true, uniqueness: true,
    format: { with: /[a-z0-9_]/, message: "only allows letters" }, length: { maximum: 40 }


  def downcase_nickname
    nickname.downcase!
  end
end
