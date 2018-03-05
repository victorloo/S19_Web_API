# api/v1/photos_controller.rb 中的 index 使用 JBuilder
# 所以需要這個檔案來對應回傳的 JSON 格式
json.partial! "photo", photo: @photo
# 傳入 partial 的參數是 @photo