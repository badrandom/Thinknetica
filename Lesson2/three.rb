#frozen_string_literal: true

puts 'Fibonacci array:'
fib_array = [0, 1]
loop do
  counter = fib_array.last(2).sum
  break if counter > 100
  fib_array << counter
end
print "#{fib_array}\n"
