# api/v1/photos_controller.rb 中的 index 使用 JBuilder
# 所以需要這個檔案來對應回傳的 JSON 格式
json.data do
  # 讓回傳資料的 Hash 結構外再包覆一層 { "data": [..] }，
  # 這樣的整理會對使用者更加友善。
  json.array! @photos do |photo|
    # json.array! 就是一筆筆取出 @photos 的內容，
    # 然後按照你指定的方式來排版

    json.partial! "photo", photo: photo
    # 傳入 partial 的參數是 photo
  end
end