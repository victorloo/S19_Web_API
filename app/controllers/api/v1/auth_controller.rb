class Api::V1::AuthController < ApiController
  # 專門用來放置和使用者認證相關的功能
  # 繼承 ApiController ，告知這是 API 相關的 controller
  before_action :authenticate_user!, only: :logout
  # 確保要先登入，才會請求登出。

  # POST /api/v1/login
  def login
    # 如果 email&password 都有輸入，則用 email 去撈對應的使用者
    if params[:email] && params[:password]
      user = User.find_by_email(params[:email])
    end

    # 如果使用者的密碼有效
    if user && user.valid_password?(params[:password])
      # 回傳以下訊息
      render json: {
        message: "Ok",
        auth_token: user.authentication_token,
        user_id: user.id
      }
    else # 如果密碼無效
      render json: { message: "Email or Password is wrong" }, status: 401
    end
    
  end

  # POST /api/v1/logout
  def logout
    # 登入時刷新 token，做為下次登入時比對用，而舊的 token 就失效了
    current_user.generate_authentication_token
    current_user.save!

    render json: {
      message: "Ok"
    }
  end

  # 登出機制的設計，是為 current_user 指派一組新的 token，
  # 除非客戶端重新登入，否則不知道新的 token。

  # 如果客戶端拿舊的 token 發出 HTTP request，在通過 ApiController 時，
  # 在 authenticate_user_from_token 裡會找不到對應的 User 物件，因此就不會登入。
end