#!/usr/bin/env ruby

require_relative "./advent3.1.rb"

def potential_gear_locations
  gear_locations = []
  raw_grid.each_with_index do |row, x|
    row.each_with_index do |col, y|
      gear_locations << [x, y] if col == "*"
    end
  end
  gear_locations
end

if __FILE__ == $0
  # p potential_gear_locations.map { |x, y| neighbours(x, y) }
  puts "1234"
end
