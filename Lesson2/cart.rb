# frozen_string_literal: true

puts 'Enter name of the product, price for 1 and its amount with spaces.'
puts "Or enter 'stop' to check the cart and total price"
command = gets.chomp

cart = {}
loop do
  break if command.downcase == 'stop'
  one_product_hash = Hash.new(0)
  one_product_array = command.split
  one_product_hash[:price_for_one] = one_product_array[1].to_f
  one_product_hash[:amount] = one_product_array[2].to_f
  one_product_hash[:price] = one_product_hash[:price_for_one] * one_product_hash[:amount]
  cart[one_product_array[0].downcase.to_sym] = one_product_hash
  puts 'Enter name of the product, its price for 1 and its amount with spaces.'
  puts "Or enter 'stop' to check the cart and total price"
  command = gets.chomp
end

puts
total_price = 0
cart.each do |name, data|
  puts "Product: #{name}  Price for one: #{data[:price_for_one]}  Amount: #{data[:amount]}  Price for all: #{data[:price]}"
  total_price += data[:price]
end
puts "Total price: #{total_price}"
