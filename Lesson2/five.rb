# frozen_string_literal: true

months_hash = {
  january: 31,
  february: 28,
  march: 31,
  april: 30,
  may: 31,
  june: 30,
  july: 31,
  august: 31,
  september: 30,
  october: 31,
  november: 30,
  december: 31
} #Просто было лень вбивать массив, взял хэш из предыдущего задания

months_array = []
months_hash.each_value { |value| months_array << value }
puts 'Enter year'
year = gets.to_i
puts 'Enter number of month'
month = gets.to_i - 1
puts 'Enter day'
day = gets.to_i

if (year % 4).zero? && (year % 100).zero? && (year % 4).zero?
  months_array[1] += 1
end
number_of_day = day
number_of_day += months_array[0..month - 1].sum # We need '-1' not to count all days of the chosen month
puts "This is the #{number_of_day} day"
