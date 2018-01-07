require 'mechanize'
require 'date'
require 'json'
require 'pry'

agent = Mechanize.new
page = agent.get("https://pitchfork.com/reviews/albums/")

review_links = page.links_with(href: %r{^/reviews/albums/\w+})

review_links = review_links.reject do |link|
  parent_classes = link.node.parent['class'].split
  parent_classes.any? { |p| %w[next-container page-number].include?(p) }
end

review_links = review_links[1...5]





puts review_links