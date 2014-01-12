class PagesController < ApplicationController
  include HighVoltage::StaticPage
  include Yelp::V2::Search::Request
  # respond_to :json

  def home
  end

  def post_random
    @location = Location.new(params.require(:location).permit(:latitude, :longitude))

    session[:latitude] = @location.latitude.to_f
    session[:longitude] = @location.longitude.to_f
  end

  def get_random
    if session[:latitude] && session[:longitude]
      client = Yelp::Client.new

      request = GeoPoint.new(
                  :term => '',
                  :category_filter => 'food,restaurants',
                  :limit => 20,
                  :radius_filter => 8047,
                  :latitude => session[:latitude],
                  :longitude => session[:longitude])
      @response = client.search(request)

      random = Random.rand(0...19)

      @response = @response['businesses'][random]
    end
  end
end