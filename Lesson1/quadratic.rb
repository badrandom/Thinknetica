#frozen_string_literal: true

print "Enter a,b and c of your quadratic \n"
print "a = "
a = gets.to_i
print "b = "
b = gets.to_i
print "c = "
c = gets.to_i
d = b**2 - 4 * a * c
if d < 0
  print "No roots! D = #{d}"
elsif d == 0
  print "D = #{d}\n"
  print "x = #{(b * -1) / (2 * a).to_f}"
else
  print "D = #{d}\n"
  print "x1 = #{((b * -1) + Math.sqrt(d).to_f) / 2 / a}\n"
  print "x2 = #{((b * -1) - Math.sqrt(d).to_f) / 2 / a}\n"
end