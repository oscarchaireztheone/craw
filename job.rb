require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'csv'
require 'mail'

PAGE_URL = "https://raleigh.craigslist.org/d/labor-gigs/search/lbg"
page = Nokogiri::HTML(open(PAGE_URL))

jobs_array = []

page.css('.content').css('.result-row').css('.hdrlnk').map do |a|
  post_name = a['href']
  #the text to search for goes here
  if post_name =~ /mason|handyman|backsplash|concrete|tile|ceramic|brick|stone|foundation|grout|bathroom|remodle/i
  jobs_array.push(post_name)
end
end



crap = CSV.read('jobs.csv') #outputs and array of arrays we just need the first index
theMoney = crap[0]  #now we have a nice camma delimeted array
news = 0
#this is where we compare the data from the csv file and the data from the newset craw
if theMoney.length >= jobs_array.length && theMoney[0] == jobs_array[0] 
  
elsif theMoney.length <= jobs_array.length && theMoney[0] != jobs_array[0]
  jobs_array.each_with_index do |url, index|
    if url == theMoney[0]
      news = index
      message = ""
      for url in jobs_array[0...news] 
        message += url + "\n"
      end
      options = { :address              => "smtp.gmail.com",
                  :port                 => 587,
                  :user_name            => 'oscarchairez65.oc@gmail.com',
                  :password             => '221Ozker',
                  :authentication       => 'plain',
                  :enable_starttls_auto => true  }

      Mail.defaults do
        delivery_method :smtp, options
      end

      Mail.deliver do
             to 'botnc.com@gmail.com'
           from 'oscarchairez65.oc@gmail.com'
        subject 'Test'
           body message
      end
    end
  end
  
end



CSV.open('jobs.csv', 'w') do |csv|
  csv << jobs_array #this needs to be updated each time to ease comparison on the next craw
end