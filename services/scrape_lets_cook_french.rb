require 'open-uri'
require 'nokogiri'

class ScrapeLetsCookFrenchService
  def call(keyword)
    url = "http://www.letscookfrench.com/recipes/find-recipe.aspx?aqt=#{keyword}"
    # TODO: return a list of `Recipes` built from scraping the web.
    html_doc = Nokogiri::HTML(open(url).read)
    results_a = []
    html_doc.search('div.m_contenu_resultat').each do |element|
       title = element.search('.m_titre_resultat').first.text.strip
       description = element.search('.m_texte_resultat').first.text.strip
       time = element.search('.m_detail_time').text.strip
       results_a << Recipe.new(title, description,time)
    end
    results_a
  end
end
