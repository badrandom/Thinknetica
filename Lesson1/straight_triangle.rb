# frozen_string_literal: true

# I decided not to do protection from wrong input. It's not required by the task.
# I also didn't make protection from non-existent triangles because it would be difficult to test the program
print "Enter 3 sides of your triangle in one string with spaces\n"
sides = gets
array_of_sides = sides.split.map(&:to_i).sort.reverse.uniq #Just tried to remember some array methods.
if array_of_sides.size == 1
  print 'Your triangle is equilateral'
elsif array_of_sides.size == 2
  print 'Your triangle is isosceles'
elsif array_of_sides[0]**2 == array_of_sides[1]**2 + array_of_sides[2]**2
  print 'Your triangle is straight'
else
  print 'Your triangle is simple'
end

