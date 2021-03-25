#frozen_string_literal: true

puts 'Array of n % 5 == 0 numbers:'
my_array = []
i = 10
while i <= 100 do
  my_array << i if (i % 5).zero?
  i += 5
end
print "#{my_array}\n"
