class User < ApplicationRecord

  has_many :questions, dependent: :delete_all
  has_many :authored_question, class_name: 'question', foreign_key: 'author_id', dependent: :nullify

  has_secure_password

  before_validation :downcase_nickname

  validates :header_color, presence: true, format: { with: /\A#\h{3}{1,2}\z/ }

  validates :email, presence: true, uniqueness: true,
    format: { with: /([a-z0-9_\.-]+)@([a-z0-9_\.-]+)\.([a-z\.]{2,6})/ }
  validates :nickname, presence: true, uniqueness: true,
    format: { with: /[a-z0-9_]/ }, length: { maximum: 40 }

  include Gravtastic
  gravtastic(secure: true, filetype: :png, size: 100, default: 'retro')

  def downcase_nickname
    nickname&.downcase!
  end

  def to_param
    nickname
  end
end
