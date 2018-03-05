class Api::V1::PhotosController < ApiController
  # 繼承 ApiController ，告知這是 API 相關的 controller
  before_action :authenticate_user!, except: :index
  # 除了 index 之外，都需要登入，好進行身份驗證
  # 而 API 的登入採用「認證機制」→ token
  # token 就像是遊戲園的入場券。
  # 你可以在售票口買票進入遊樂園，但是但是到每個攤位時，
  # 都還是要檢查你的票券是否有效，才會讓你使用服務。
  
  # GET http://localhost:3000/api/v1/photos
  # 加上 http verb & url 好提醒這功能
  def index
    @photos = Photo.all

    # 因為使用 gem: JBuilder，自動安排 JSON 回傳格式
    # 所以以下的 render json 可以刪除
#    render json: {
      # render 將 @photos 轉成 JSON 字串來輸出。
#      data: @photos.map do |photo|
#        #當有多筆資料的時候，習慣會在最外層包一層 data
#        {
#          title: photo.title,
#          date: photo.date,
#          description: photo.description
            # 以上是設定 API 能使用的資料屬性有哪些
#         }
#      end
#    }
  end

  # GET http://localhost:3000/api/v1/photos/:id
  # 加上 http verb & url 好提醒這功能
  def show
    @photo = Photo.find_by(id: params[:id])
    # 使用 find_by 可以在找不到物件內容時，回傳 nil
    # 使用 find ，在找不到物件內容時，會回傳 Error，讓你的程式壞掉。
    if !@photo
      render json: {
        message: "Can't find the photo!",
        status: 400
         # 400 = HTTP 狀態碼 =「Bad Request」，
         # 表示客戶端的請求無效，提醒客戶端的開發者應該查明原因。
      }
    else
      render "api/v1/photos/show" # 寫上檔案路徑會比較容易閱讀，但事實上也可以不寫

      # 因為使用 gem: JBuilder，自動安排 JSON 回傳格式
      # 所以以下的 render json 可以刪除
#      render json: {
#        title: @photo.title,
#        date: @photo.date,
#        description: @photo.description
#      }
    end
  end
  
  # POST http://localhost:3000/api/v1/photos
  # 加上 http verb & url 好提醒這功能
  def create
    @photo = Photo.new(photo_params)
    if @photo.save
      render json: {
        message: "Photo created successfully!",
        result: @photo
      }
    else
      render json: {
        errors: @photo.errors
      }
    end
  end

  # PATCH http://localhost:3000/api/v1/photos/:id
  # 加上 http verb & url 好提醒這功能
  def update
    @photo = Photo.find_by(id: params[:id])
      if @photo.update(photo_params)
        render json: {
          message: "Photo updated successfully!",
          result: @photo
        }
      else
        render json: {
          errors: @photo.errors
        }
      end
  end

  # DELETE http://localhost:3000/api/v1/photos/:id
  # 加上 http verb & url 好提醒這功能
  def destroy
    @photo = Photo.find_by(id: params[:id])
    @photo.destroy
      render json: {
        message: "Photo destroy successfully!"
      }
  end
  
  private

  def photo_params
    params.permit(:title, :date, :description, :file_location)
    #params.require(:id_name).permit(:variable)
    # API 使用上不需要 .require()，是因為之前搭配的是 form_for，
    # 回傳的 Hash 結構會在最外層打包一層 photo: {.....}
  end
  
end