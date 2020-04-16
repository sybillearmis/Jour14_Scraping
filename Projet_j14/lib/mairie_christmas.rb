require 'rubygems'
require 'nokogiri'
require 'open-uri'

def get_townhall_email(townhall_url)

page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/95/ableiges.html"))

page.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').each do |email|
    puts email.text
    end
end


 # Boucle array villes

    page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))

    valdoise_towns_array = []  

    page.xpath('//td/p/a').each do |ville| # on retire le numéro entre crochet après "tr" pour que ca scrape tous les numéros de tr
        ville.text
        valdoise_towns_array << ville.text # on a ici l'array des villes du Val d'Oise

    end

    print valdoise_towns_array.size


    townhall_urls_array = []
    for i in 0...valdoise_towns_array.size do
print townhall_urls_array << "http://annuaire-des-mairies.com/95/#{valdoise_towns_array[i]}.html"
    end




