require 'watir-webdriver'
class WeatherController < ApplicationController
  include ActionView::Helpers::NumberHelper

  def get_weather
    lat = number_with_precision(params[:lat], :precision => 2).to_s
    lon = number_with_precision(params[:lon], :precision => 2).to_s
    @uri = "http://www.weather.com/wx/10day?locid=" << lat << "," << lon << "&locale=es_US"
    b = Watir::Browser.new :phantomjs
    b.goto @uri
    card = Nokogiri::HTML(b.html).xpath('//span[text()="'<< params[:date] <<'"]/../..')

    @img = "http://www.weather.com" << card.xpath('following-sibling::div[1]//img/@src').to_s
    @temp_max = card.xpath('following-sibling::p[1]//text()').to_s
    @temp_min = card.xpath('following-sibling::p[2]//text()').to_s

    b.close

    respond_to do |format|
      format.js
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def weather_params
      params.require(:lat, :lon, :date)
    end
end
