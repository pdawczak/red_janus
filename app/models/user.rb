class User < ActiveRecord::Base
  using Utils::LegacyizeHash
  include Utils::LegacyActiveRecord

  rewrite plain_password: :password

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
