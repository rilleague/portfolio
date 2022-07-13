class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
    # 半角英数字6文字以上でないと保存出来ない
    PASSWORD_REGEX = /\A[a-z\d]{6,}+\z/i.freeze
    validates_format_of :password, with: PASSWORD_REGEX
    # 主にはドットとアットマークを含まないと保存できない,同じメールアドレスは保存出来ない
    validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i}, uniqueness: true
    # 同じニックネームは保存出来ない
    validates :nickname, uniqueness: true
  end
end
