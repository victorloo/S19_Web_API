namespace :dev do

  task fetch_user: :environment do

    User.destroy_all

    url = "https://uinames.com/api/?ext&region=england"
    # 提供 API 服務的網址

    15.times do
      response = RestClient.get(url)
      # 告知要用 gem: rest-client 產生request&response
      data = JSON.parse(response.body)
      # response 從 JSON 轉換成 object

      user = User.create!(
        name: data["name"],
        email: data["email"],
        password: data["password"],
        gender: data["gender"],
        age: data["age"],
        region: data["region"],
        phone: data["phone"],
        avatar: data["photo"] 
      )
      # 依照需求，選擇 data 中特定屬性後，完成 user 創立

      puts "created user #{user.name}"
    end

    puts "now you have #{User.count} users data"
  end

end