require 'rubygems'
require 'nokogiri'
require 'open-uri'


page = Nokogiri::HTML(open("https://annuaire-des-mairies.com/val-d-oise.html"))



# avec cette méthode on va chercher l'email de chaque commune, avec l'adresse html de chaque commune !!! On va faire le xpath à partir de l'adresse email de chacune des communes, donc il faut récolter cette url

def get_townhall_email(townhall_url)

email = townhall_url.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]')
    return email.text

end

# ci-dessus on a fait la méthode, mais il faut maintenant pourvoir générer les urls de chaque commune. 
# on s'y met

def get_townhall_urls(page)

######### initialisation des arrays 

valdoise_towns_array = []   # Initialisation de l'array des villes
array_town_emails = []   # Initialisation de l'array des emails
array_fin = []  #initialisation du tableau final des résultats


######### Boucle array villes

    page = Nokogiri::HTML(open("https://annuaire-des-mairies.com/val-d-oise.html"))

    page.xpath('//td/p/a').each do |ville| 
        ville.text
        valdoise_towns_array << ville.text # on a ici l'array des villes du Val d'Oise
    end

##########

 # Recupération des url
    page = Nokogiri::HTML(open("https://annuaire-des-mairies.com/val-d-oise.html"))
    page.xpath('//td/p/a/@href').each do |urls|  
        urls = urls.text
        # on obtient alors ./95/villers-en-arthies.html   ./95/villiers-adam.html     ./95/villiers-le-bel.html   etc....

        # Retrait du point devant les urls
        urls.slice!(0)      # on obtient alors /95/villers-en-arthies.html   /95/villiers-adam.html     /95/villiers-le-bel.html   etc....

        # Ajout du début du lien
        urls = "https://annuaire-des-mairies.com" + urls      # on obtient alors https://annuaire-des-mairies.com/95/villers-en-arthies.html  etc... > l'url finale !
 

        # Appel de la fonction de recherche d'email avec le nouvel url
        # Boucle array emails

        emails = get_townhall_email(Nokogiri::HTML(open(urls)))  # on remplace ici la valeur de page dans la 1ère méthode
        array_town_emails << emails
    end
    
    # Création hash joignant les viles et les emails
    hash = Hash[valdoise_towns_array.zip(array_town_emails)]
     # Création d'un array de hash
     hash.each {|i| array_fin << {i[0] => i[1]}}
     puts array_fin

end

get_townhall_urls(page)