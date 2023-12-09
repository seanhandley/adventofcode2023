#!/usr/bin/env ruby

def input
  @input ||= STDIN.read.split("\n").map { |line| line.scan(/\d+/) }
end

def time_limits
  input.first.map(&:to_i)
end

def record_distances
  input.last.map(&:to_i)
end

def race_possibilities_count(time_limit, distance_limit)
  0.upto(time_limit).count do |time_held|
    (-time_held ** 2) + time_limit * time_held > distance_limit
  end
end

def ways_to_win
  time_limits.zip(record_distances).map do |time_limit, record_distance|
    race_possibilities_count(time_limit, record_distance)
  end
end

def margin_of_error
  ways_to_win.reduce(:*)
end

if __FILE__ == $0
  p margin_of_error
end
