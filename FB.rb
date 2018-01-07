require 'mechanize'
require 'date'
require 'json'
require 'pry'

agent = Mechanize.new
agent.user_agent_alias = 'Android'
login_page = agent.get('https://facebook.com/')
login_form = agent.page.form_with(:method => 'POST')
login_form.email = 'oscarchairez65@att.net'
login_form.pass = '221Ozker'
agent.submit(login_form)
  
Pry.start(binding)
