require 'nokogiri'
require 'open-uri'
require 'json'
require_relative 'recipe'

class ScrapeService
  def initialize(keyword)
    @keyword = keyword
  end

  def call
    html_doc = Nokogiri::HTML(URI.open("https://www.bbcgoodfood.com/search?q=#{@keyword}").read)
    info_hash = JSON.parse(html_doc.search('.js-search-data').text)["results"]
    html_doc.search('.standard-card-new').first(5).map do |card|
      name = card.search('.standard-card-new__article-title').text.strip
      recipe_hash = info_hash.find { |hash| hash['title'] == name }
      description = recipe_hash['description']
      rating = recipe_hash['userRatings']['starRatingAverage']
      prep_time = recipe_hash['totalTimeArray']['totalTimeHumanReadable']
      Recipe.new(name, description, rating, false, prep_time)
    end
  end
end
