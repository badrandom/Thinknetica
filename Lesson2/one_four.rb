#frozen_string_literal: true

#Part one
puts 'Months with 30 days:'
months = {
    :january => 31,
    :february => 28,
    :march => 31,
    :april => 30,
    :may => 31,
    :june => 30,
    :july => 31,
    :august => 31,
    :september => 30,
    :october => 31,
    :november => 30,
    :december => 31
}

months.each { |month, days| puts month.to_s if days == 30 }


#Part 2

puts
puts 'Array of n % 5 == 0 numbers:'
my_array = Array.new
i = 10
while i <= 100 do
  my_array << i if (i % 5).zero?
  i += 5
end
print "#{my_array}\n"

#Part 3

puts
puts 'Fibonacci array:'
fib_array = [0, 1]
fib_index = 2
loop do
  fib_array << fib_array[fib_index - 2] + fib_array[fib_index - 1]
  fib_index += 1
  break if fib_array[fib_index - 2] + fib_array[fib_index - 1] > 100
end
print "#{fib_array}\n"

#Part 4
puts 'Hash of vowels:'
vowels = {}
letters_array = ('A'..'Z').to_a
letters_array.each_index do |i|
  vowels[letters_array[i].to_sym] = i + 1 if letters_array[i] =~ /[AEIOUY]/
end
vowels.each { |letter, number| puts "#{letter}: #{number}" }
