require 'rubygems'
require 'nokogiri'
require 'open-uri'
PAGE_URL = "http://ruby.bastardsbook.com/files/hello-webpage.html"
page = Nokogiri::HTML(open(PAGE_URL))

#does the same thing as the line below it
#page = Nokogiri::HTML(open("https://www.wikipedia.org/"))
#puts page.class
#does the dame thing as the top line
#page = Nokogiri::HTML(RestClient.get("https://www.wikipedia.org/"))
#puts page.class
news_link = page.css("a").select{|link| link['data-category'] == "news"}
news_link.each{|link|}