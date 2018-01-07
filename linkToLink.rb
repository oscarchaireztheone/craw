require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'fileutils'
require 'pry'

#we the url of the website we are crawling
BASE_URL = 'https://catalog.data.gov'
#the url extension of the data that we want to get
BASE_DIR = '/dataset?page='
#the direcrory where we want to stroe the data on the local machine
LOCAL_DIR = 'data-hold/datagov-pages'

#make a directory if id does not alread exist.
FileUtils.makedirs(LOCAL_DIR) unless File.exists?LOCAL_DIR

# get metainfo from first page:
page = Nokogiri::HTML(open(BASE_URL+BASE_DIR + '1'))

# write the HTML for page 1 to disk
File.open("#{LOCAL_DIR}/1.html", 'w'){|f| f.write(page.to_html)}
#this lets you interact with thepulled html from the terminal, a good way to test your net
Pry.start(binding)

lengthOfnode = page.css("div.pagination.pagination-centered li a").length
lastPageNum = lengthOfnode - 2
#the last bit of code on this line allows you to pull the number in a url using regep, the match method returns an array so the index value is called to spcify what to turn into an integer.
page.css("div.pagination.pagination-centered li a")[lastPageNum]['href'].match(/page=(\d+)/)[1].to_i

puts "Iterating from 2 to #{lastPageNum}"

for pg_number in 2..4 do
  puts "Getting #{pg_number}"
  File.open("#{LOCAL_DIR}/#{pg_number}.html", 'w') do |f| 
    f.write( open("#{BASE_URL}#{BASE_DIR}#{pg_number}").read )
  end
end