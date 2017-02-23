require 'open-uri'

table_nodes = Nokogiri::HTML(open("http://www.languagedaily.com/learn-german/vocabulary/common-german-words")).xpath("//tr//td")

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
  nodes.select {|td| td['class'] == 'bigLetter'}.map {|tag| tag.content}
end

def english_translations(nodes, indexes)
  translations = []

  nodes.each_with_index do |node, idx|
    translations << node.content if indexes.include?(idx)
  end

  translations
end

eng_indexes = indexes_of_eng_translations(table_nodes)
eng_translations =  english_translations(table_nodes, eng_indexes)
de_words = german_words(table_nodes)
translation_pairs = de_words.zip(eng_translations)

translation_pairs.each do |pair|
  Card.create(
    original_text: pair[0],
    translated_text: pair[1]
  )
end

puts "These cards have been generated:"
Card.all.each {|x| puts "Original Text: #{x.original_text} | Translated Text: #{x.translated_text} | Review Date: #{x.review_date}" }

