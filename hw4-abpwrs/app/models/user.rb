class User < ActiveRecord::Base
  validates :user_id, uniqueness: true, presence: true, allow_blank: false
  validates :email, presence: true, allow_blank: false

  def User.create_user(params)
    params[:session_token] = SecureRandom.base64(32)
    User.create!(params)
  end
end
