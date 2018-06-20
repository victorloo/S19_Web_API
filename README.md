# Alpha Camp Rails習題︰Photo Album with API

## 體驗方式
* 帳號：root@example.com
* 密碼：12345678

## 如何啟動？

```ruby
git clone git@github.com:victorloo/S19_Web_API.git
bundle install
rake db:migrate
rails dev:fetch_user
```

## 開發環境

* Ruby version: 2.4.3
* Rails version: 5.1.4

### 使用的 gem

* [devise](https://rubygems.org/gems/devise)
* [carrierwave](https://rubygems.org/gems/carrierwave)
* [bootstrap-sass](https://rubygems.org/gems/bootstrap-sass)
* [rest-client](https://rubygems.org/gems/rest-client)
* [omniauth-facebook](https://rubygems.org/gems/omniauth-facebook)

## 使用者故事
### 照片
* 用戶可以瀏覽所有照片
* 用戶可以新增一筆照片
* 用戶可以瀏覽一筆照片
* 用戶可以修改一筆照片
* 用戶可以上傳照片
* 用戶可以刪除一筆照片

### API
* 用戶可以瀏覽照片
* 用戶可以新增一筆照片
* 用戶可以修改一筆照片
* 用戶可以刪除一筆照片
* 可以用 FB 認證來登入會員
