require "nokogiri"
require "open-uri"

class ScrappingService

  def initialize(ingredient)
    @ingredient = ingredient
    @urls = []
  end

  def list
    url = "https://www.allrecipes.com/search?q=#{@ingredient}"
    doc = Nokogiri::HTML.parse(URI.open(url).read, nil, "utf-8")

    names = []
    doc.search('.mntl-card-list-items').first(5).each do |link|
      names << link.search('.card__title-text').text
      @urls << link.attribute('href').value
    end
    names
  end

  def import(index)
    url = @urls[index]
    doc = Nokogiri::HTML.parse(URI.open(url).read, nil, "utf-8")
    name = doc.search('h1').text.strip
    description = doc.search('#article-subheading_1-0').text.strip
    rating = doc.search('#mntl-recipe-review-bar__rating_1-0').text.strip
    prep_time = doc.search('.mntl-recipe-details__value')[2].text

    Recipe.new(name, description, rating, prep_time)
  end
end
