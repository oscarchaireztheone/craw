require 'mechanize'
require 'pry'


mechanize = Mechanize.new

page = mechanize.get('https://www.infobae.com/america/')

Pry.start(binding)
