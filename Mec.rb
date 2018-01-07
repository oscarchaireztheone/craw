require 'rubygems'
require 'mechanize'
require 'open-uri'

agent = Mechanize.new
agent.get("http://somepagewithform.com")

#one wat to get the form off of a page that you opened with mechanize
form = agent.page.parse.css('form')[0]

#this is another way to get the form, with more concise code
agen.page.forms[0]

# get the list of the input fields with this bit of code
agent.page.forms[0].fields

#how to set valuse for the fields in a form 
agent.page.forms[0]["first_name"] = "Oscar"
agent.page.forms[0]["last_name"] = "Chairez"
agent.page.forms[0]["phone"] = "7564923"


#this is how you would submit the form
agent.page.forms[0].submit


#after the page is submited, agent now holds the results of the submited form, since it holds whatever page we are currently on, no need to declare another variable to hold the new page.


