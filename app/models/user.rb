class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]
  # 加上 :omniauthable, omniauth_providers: [:facebook]
  # 允許使用 OmnAuth
  # 以上設定，使Devise 會運用路由設定裡的 devise_for :users，
  # 產生出兩個新的方法：
  # user_facebook_omniauth_authorize_path
  # user_facebook_omniauth_callback_path

  before_create :generate_authentication_token
  # before_create 可以確保在新紀錄「存入資料庫前」一定會觸發這個方法。
  # 新建立的 user 都會自動攜帶專屬的 token

  # 使用前先在 schema， users上增加 t.string "authentication_token"
  # 確保 User Model 裡每個紀錄都會帶有 token 資訊
  # 這可以用在 dev 上，並且更新現有 user 的資料
  # 也就是說， data tables 的更新要用方法觸發，不能用 update
  def generate_authentication_token
    # Devise.friendly_token 會自動產生 20 字元長的亂數
    # 是一組亂碼，用於辨識身份，內容不具意義
    self.authentication_token = Devise.friendly_token
  end

  def self.from_omniauth(auth)
    # Case 1: Find existing user by facebook uid
    # User 不是第一次用 Facebook 登入：
    # 因此我們可以用 fb_uid 找到一個現存的 User。
    user = User.find_by_fb_uid( auth.uid )
    if user 
      user.fb_token = auth.credentials.token # 把 Facebook 回傳的 token 寫進 User 物件
      user.save!
      return user
    end

    # Case 2: Find existing user by email
    # User 是第一次用 Facebook 登入，但他也用同一組 email 註冊過帳號：
    # 若是如此，你就可以拿出 Facebook 回傳的 email，從資料庫裡找出一個現存的 User。
    existing_user = User.find_by_email( auth.info.email )

    if existing_user
      existing_user.fb_uid = auth.uid
      existing_user.fb_token = auth.credentials.token # 把 Facebook 回傳的 token 寫進 User 物件
      existing_user.save!
      return existing_user
    end

    # Case 3: Create new password
    # User 沒有註冊過，且是第一次用 Facebook 登入：
    # 若是如此，你需要建立一個全新的 User 紀錄。
    user = User.new
    user.fb_uid = auth.uid
    user.fb_token = auth.credentials.token # 把 Facebook 回傳的 token 寫進 User 物件
    user.email = auth.info.email
    user.password = Devise.friendly_token[0,20]
    user.save!
    return user

  end
end
