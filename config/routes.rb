Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  # 實作一個新的 controller 去處理 callback
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "photos#index"
  resources :photos
  resources :users


  namespace :api, defaults: {format: :json} do
  # api 目的是告知說這是專門開放給 api 使用
  # defaults → 將回傳給客戶端的格式預設為 JSON，因為原本預設是 .html
    namespace :v1 do
    # 要幫各個版號建立專屬的名稱，就算發布新版，也要留下舊版
      resources :photos, only: [:index, :create, :show, :update, :destroy]
      # 開放的 action 中，剔除需要使用表單的
      
      # 設定「登入／登出」的請求位置
      post "/login" => "auth#login"
      post "/logout", to: "auth#logout"

      # 對應的 controller︰ Api::V1::AuthController

      # auth#login機制︰
      # 客戶端向 auth#login 發出 HTTP request，
      # 並攜帶 email 和 password 參數

      # 用 email 和 password 比對 users table，
      # 若到對應 User 紀錄，就取出該紀錄的 token，
      # 做為 auth_token 參數回傳。

      # ApiController 上設置一個 authenticate_user_from_token 方法
      # 若帶有 auth_token 的 request 經過，就會比對 users table 裡的 token 資料，
      # 找出對應的 User 物件，並執行 sign_in，完成使用者登入。
    end
  end

end