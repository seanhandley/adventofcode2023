#!/usr/bin/env ruby

def input
  @input ||= STDIN.read.split("\n\n")
end

def seeds
  input.first.scan(/\d+/).map(&:to_i)
end

def maps
  input[1..-1].map { |m| parse_map(m) }
end

# seed-to-soil map:
# destination-start source-start range-length
# ... repeat ...
# TODO: make this a much more efficient data structure
def parse_map(map)
  head, *tail = map.split("\n")
  source_name, destination_name = head.match(/(\w+)-to-(\w+)/).captures
  ranges = tail.map do |line|
    destination_start, source_start, length = line.split.map(&:to_i)
    d = destination_start...(destination_start + length)
    s = source_start...(source_start + length)
    s.zip(d).to_h
  end
  {
    source_name: source_name,
    destination_name: destination_name,
    ranges: ranges.reduce(:merge)
  }
end

def location(seed)
  i = seed
  maps.each do |map|
    i = map[:ranges][i] || i
  end
  i
end

if __FILE__ == $0
  # p seeds.map { |seed| location(seed) }.min
  puts "1234"
end
