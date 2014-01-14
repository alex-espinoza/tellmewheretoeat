class PagesController < ApplicationController
  include Yelp::V2::Search::Request

  def home
  end

  def location
    @location = Location.new(params.require(:location).permit(:latitude, :longitude))
    session[:latitude] = @location.latitude.to_f
    session[:longitude] = @location.longitude.to_f
  end

  def result
    if session[:latitude] && session[:longitude]
      restaurant = search_and_get_random_restaurant
      @restaurant_name = restaurant['name']
      @restaurant_type = restaurant['categories'].map(&:first).join(', ')
      @restaurant_phone = restaurant['display_phone']
      @restaurant_info = restaurant['url']
      @restaurant_address = [restaurant['location']['display_address'].first, restaurant['location']['display_address'].last]
    end
  end

  private

  def search_and_get_random_restaurant
    search_categories = restaurant_categories.sample(20).join(',')
    search_result = search_via_yelp_api(search_categories)
    number_of_results = search_result['businesses'].length - 1
    random = Random.rand(0...number_of_results)
    return search_result['businesses'][random]
  end

  def restaurant_categories
    [
      'afghani',
      'african',
      'newamerican',
      'tradamerican',
      'arabian',
      'argentine',
      'armenian',
      'asianfusion',
      'australian',
      'austrian',
      'bangladeshi',
      'bbq',
      'basque',
      'belgian',
      'brasseries',
      'brazilian',
      'breakfast_brunch',
      'british',
      'buffets',
      'burgers',
      'burmese',
      'cafes',
      'cafeteria',
      'cajun',
      'cambodian',
      'caribbean',
      'catalan',
      'cheesesteaks',
      'chicken_wings',
      'chinese',
      'comfortfood',
      'creperies',
      'cuban',
      'czech',
      'delis',
      'diners',
      'ethiopian',
      'hotdogs',
      'filipino',
      'fishnchips',
      'fondue',
      'food_court',
      'foodstands',
      'french',
      'gastropubs',
      'german',
      'gluten_free',
      'greek',
      'halal',
      'hawaiian',
      'himalayan',
      'hotdog',
      'hotpot',
      'hungarian',
      'iberian',
      'indpak',
      'indonesian',
      'irish',
      'italian',
      'japanese',
      'korean',
      'kosher',
      'laotian',
      'latin',
      'raw_food',
      'malaysian',
      'mediterranean',
      'mexican',
      'mideastern',
      'modern_european',
      'mongolian',
      'moroccan',
      'pakistani',
      'persian',
      'peruvian',
      'pizza',
      'polish',
      'portuguese',
      'russian',
      'salad',
      'sandwiches',
      'scandinavian',
      'scottish',
      'seafood',
      'singaporean',
      'slovakian',
      'soulfood',
      'soup',
      'southern',
      'spanish',
      'steak',
      'sushi',
      'taiwanese',
      'tapas',
      'tapasmallplates',
      'tex-mex',
      'thai',
      'turkish',
      'ukrainian',
      'vegan',
      'vegetarian',
      'vietnamese'
    ]
  end

  def search_via_yelp_api(categories)
    client = Yelp::Client.new
    request = GeoPoint.new(
                :term => '',
                :category_filter => categories,
                :limit => 20,
                :radius_filter => 8047,
                :latitude => session[:latitude],
                :longitude => session[:longitude])
    return client.search(request)
  end
end