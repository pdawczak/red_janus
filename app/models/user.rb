class User < ActiveRecord::Base
  include Utils::LegacyActiveRecord

  rewrite plain_password: :password

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_create :set_username

  def full_name
    "#{first_names} #{middle_names} #{last_names}".squeeze
  end

  def initials
    full_name
      .parameterize(" ")
      .split
      .map(&:first)
      .join
  end

  private

    def set_username
      num = User.where("username LIKE ?", "#{initials}%").count

      begin
        username = "#{initials}#{num += 1}"
      end while User.where(username: username).exists?

      self.username = username
    end
end
