#!/usr/bin/env ruby

def raw_grid
  @raw_grid ||= STDIN.read.split.map(&:chars)
end

def neighbours(x, y)
  n = []
  n << raw_grid[x-1][y-1] if x > 0 && y > 0
  n << raw_grid[x-1][y]   if x > 0
  n << raw_grid[x-1][y+1] if x > 0 && y < raw_grid[0].length - 1
  n << raw_grid[x][y-1]   if y > 0
  n << raw_grid[x][y+1]   if y < raw_grid[0].length - 1
  n << raw_grid[x+1][y-1] if x < raw_grid.length - 1 && y > 0
  n << raw_grid[x+1][y]   if x < raw_grid.length - 1
  n << raw_grid[x+1][y+1] if x < raw_grid.length - 1 && y < raw_grid[0].length - 1
  n
end

def symbol?(char)
  char != "." && char !~ /\d+/
end

def grid_with_symbol_annotation
  raw_grid.each_with_index.map do |row, x|
    row.each_with_index.map do |col, y|
      [col, neighbours(x, y).any? { |n| symbol?(n) }]
    end
  end
end

def adjacent_part_numbers
  numbers = []
  number = []
  inside_number = false
  grid_with_symbol_annotation.flatten(1).each do |char, symbol|
    if char =~ /\d+/
      number << [char, symbol]
      inside_number = true
    elsif inside_number
      numbers << number.map(&:first).join.to_i if number.map(&:last).any?
      number = []
      inside_number = false
    end
  end
  numbers
end

if __FILE__ == $0
  p adjacent_part_numbers.sum
end
