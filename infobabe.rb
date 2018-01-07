require 'mechanize'
require 'pry'
require 'json'
require 'summarize'

agent = Mechanize.new

page = agent.get('https://www.infobae.com/america/')

#this gets all of the article links with the huge, xl and large headlines
article_links = page.search('div.headline.huge')
article_links += page.search('div.headline.xx-large')
article_links += page.search('div.headline.x-large')
article_links += page.search('div.headline.large')
article_links = article_links.search('a')

links_array = []
article_links.each { |link|
  uri = Mechanize::Page::Link.new(link, agent, page)
  links_array.push(uri)
}

articles = links_array.map do |link|
  article = link.click
  title = article.search('div.row').search('header.article-header').search('h1')[0].text
  bodies = article.search('p.element.element-paragraph')
  body = ""
  bodies.each { |tex|
    body += tex.text
  }
  {
    title: title,
    body: body
  }
end

  #puts JSON.pretty_generate(articles)

Pry.start(binding)
