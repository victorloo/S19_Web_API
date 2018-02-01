class Api::V1::PhotosController < ApiController

  # GET http://localhost:3000/api/v1/photos
  def index
    @photos = Photo.all
    render json: {
      data: @photos.map do |photo|
        {
          title: photo.title,
          date: photo.date,
          description: photo.description
        }
      end
    }
  end

  # GET http://localhost:3000/api/v1/photos/:id
  def show
    @photo = Photo.find_by(id: params[:id])
    if !@photo
      render json: {
        message: "Can't find the photo!",
        status: 400
      }
    else
      render json: {
        title: @photo.title,
        date: @photo.date,
        description: @photo.description
      }
    end
  end
  
end