class ApiController < ActionController::Base
  # ActionController::Base 是所有 controller 的 superclass
  before_action :authenticate_user_from_token!
  # 沒有 protect_from_forgery with: :exception
  # 所以不會啟動瀏覽器的安全檢查，API 的請求與回應將通過瀏覽器

  # 利用 token 讓使用者登入
  def authenticate_user_from_token!
    if params[:auth_token].present?
     user = User.find_by_authentication_token(params[:auth_token])
     # find_by_authentication_token(params[:auth_token]) 
     # 就是拿 HTTP request 上的 auth_token 參數，
     # 去比對 User Model 裡的 authentication_token 參數，
     # 找到某個特定的 User 物件。

     # 使用 find_by 方法，比起 find 只能用 id 來搜尋，
     # find_by 可以組合的參數更多。

     # sign_in 是 Devise 的方法，使其登入
     sign_in(user, store: false) if user
    end
  end

  # 登入的機制︰
  # 當 client 端送出「登入」請求，並附上帳號密碼，
  # server 端驗證後回傳 token 參數， 
  # client 端與 server 端的 token 相同，
  # 可以通過 authenticate_user_from_token! 的驗證。

  # 登出的機制︰
  # 當client 端請求「登出」，server 會刷新 token 但不回傳，
  # 兩邊 token 不一致，
  # 因此不會通過 authenticate_user_from_token! 的驗證。

end