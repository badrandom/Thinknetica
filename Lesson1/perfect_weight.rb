# frozen_string_literal: true

print "Hello! What is your name?\n"
name = gets.chomp.capitalize
print "What is your height?\n"
height = gets.to_i
perfect_weight = (height - 110) * 1.15
if perfect_weight.positive?
  print "#{name}, your perfect weight is #{perfect_weight.round(1)} kilograms."
else
  print "#{name}, you already have your perfect weight!"
end
