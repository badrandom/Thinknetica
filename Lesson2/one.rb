#frozen_string_literal: true

puts 'Months with 30 days:'
months = {
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
}

months.each { |month, days| puts month.to_s if days == 30 }
