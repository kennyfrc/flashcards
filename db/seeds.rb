require 'open-uri'
require 'mechanize'

agent = Mechanize.new
all_links = []
initial_link = 'http://www.languagedaily.com/learn-german/vocabulary/common-german-words'
page = agent.get(initial_link)
other_links = page.links.uniq { |link| link.uri.to_s.match('/common-german-words-') }
other_links.each do |link|
  all_links << "http://www.languagedaily.com#{link.uri}" if link.uri.to_s != ''
end
all_links = all_links.unshift(initial_link)

def indexes_of_eng_translations(nodes)
  translation_indexes = []
  last_translation_index = nodes.size - 2

  while last_translation_index > 5
    translation_indexes.unshift(last_translation_index)
    last_translation_index -= 4
  end

  translation_indexes
end

def german_words(nodes)
  nodes.select { |td| td['class'] == 'bigLetter' }.map { |tag| tag.content }
end

def english_translations(nodes, indexes)
  translations = []

  nodes.each_with_index do |node, idx|
    translations << node.content if indexes.include?(idx)
  end

  translations
end

def generate_translations(nodes, english_indexes)
  eng_translations = english_translations(nodes, english_indexes)
  de_words = german_words(nodes)
  translation_pairs = de_words.zip(eng_translations)

  translation_pairs.each do |pair|
    Card.create(
      original_text: pair[0],
      translated_text: pair[1]
    )
  end

  Card.all
end

def seed_data(links)
  translations = ''
  links.each do |link|
    table_nodes = Nokogiri::HTML(open(link)).xpath("//tr//td")
    eng_indexes = indexes_of_eng_translations(table_nodes)
    translations = generate_translations(table_nodes, eng_indexes)
  end
  translations
end

seed_cards = seed_data(all_links)

puts "These cards have been generated:"
seed_cards.each { |x| puts "Original Text: #{ x.original_text } | Translated Text: #{ x.translated_text } | Review Date: #{ x.review_date }" }



