#frozen_string_literal: true

puts 'Fibonacci array:'
fib_array = [0, 1]
counter = fib_array.last(2).sum
loop do
  fib_array << counter
  counter = fib_array.last(2).sum
  break if counter > 100
end
print "#{fib_array}\n"
