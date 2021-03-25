#frozen_string_literal: true

puts 'Hash of vowels:'
vowels = {}
letters_array = ('A'..'Z').to_a
letters_array.each_index do |i|
  vowels[letters_array[i]] = i + 1 if letters_array[i] =~ /[AEIOUY]/
end
vowels.each { |letter, number| puts "#{letter}: #{number}" }
