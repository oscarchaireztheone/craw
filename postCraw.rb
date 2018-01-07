require 'rubygems'
require 'restclient'
require 'nokogiri'
# set the url of the source of the data
REQUEST_URL = "http://docquery.fec.gov/cgi-bin/fecimg"

#dynamically set the search term
name_term = 'dan'

#do everything in the if term if a psot rerquest to the url with the search term, is honored. this is a way of submiting a form to a url
if page = RestClient.post(REQUEST_URL, {'name'=>name_term, 'submit'=>'Get+Listing'}) 
  #simple way to let the interface know that the if statment executed
  puts "Success finding search term: #{name_term}"
  #open or creat a file in the specified directory, and write out the body of the page, in this case raw html
  File.open("data-hold/fecimg-L#{name_term}.html", 'w'){|f| f.write page.body}
  #creat a Nokogiri instance of the page
  npage = Nokogiri::HTML(page)
  #mane an array of the parsed data, using the rows of the page
  rows = npage.css('table tr')
  #put the number of rows in the array or hash
  puts "#{rows.length} rows"
  #return all the elements of that row, seperate by a coman and do that same thing for every row.
  rows.each do |row|
    puts row.css('td').map{|td| td.text}.join(', ')
  end
end 