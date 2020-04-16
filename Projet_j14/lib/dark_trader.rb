require 'rubygems'
require 'nokogiri'
require 'open-uri'


page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))

# From the website, get an array of the currencies name
currency_name_array = []  

page.xpath('//*[@id="__next"]/div/div[2]/div[1]/div[2]/div/div[2]/div[3]/div/table/tbody/tr/td[3]/div').each do |name| # on retire le numéro entre crochet après "tr" pour que ca scrape tous les numéros de tr
    name.text
    currency_name_array << name.text
  end


# From the website, get an array of the currencies price
currency_value_array = []

page.xpath('//*[@id="__next"]/div/div[2]/div[1]/div[2]/div/div[2]/div[3]/div/table/tbody/tr/td[5]/a').each do |value| # on retire le numéro entre crochet après "tr" pour que ca scrape tous les numéros de tr
    value.text
    currency_value_array << value.text
  end


  # Convert my 2 previous arrays into hash
currency_result = Hash[currency_name_array.zip(currency_value_array)]

# Création d'un array de hash
currency_result_final = []
currency_result.each {|i| currency_result_final << {i[0] => i[1]}}
puts currency_result_final




