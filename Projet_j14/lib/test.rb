require 'rubygems'
require 'nokogiri'
require 'open-uri'

valdoise_towns_array = []   # Initialisation de l'array des villes

page = Nokogiri::HTML(open("https://annuaire-des-mairies.com/val-d-oise.html"))


page.xpath('//td/p/a').each do |ville| 
 ville.text
valdoise_towns_array << ville.text # on a ici l'array des villes du Val d'Oise
end

print valdoise_towns_array




