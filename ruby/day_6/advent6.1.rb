#!/usr/bin/env ruby

# Time:      7  15   30
# Distance:  9  40  200
def input
  @input ||= STDIN.read.split("\n").map { |line| line.scan(/\d+/).map(&:to_i) }
end

def time_limits
  input.first
end

def record_distances
  input.last
end

def race_possibilities(time_limit)
  velocity = 0
  distance = 0
  0.upto(time_limit).map do |time_held|
    distance = 0
    velocity = time_held
    (time_limit - time_held).downto(1).each do
      distance += velocity
    end
    [time_held, distance]
  end
end

def fast_race_possibilities_count(time_limit, distance_limit)
  velocity = 0
  distance = 0
  0.upto(time_limit).map do |time_held|
    (-time_held ** 2) + time_limit * time_held > distance_limit
  end
end

def ways_to_win
  time_limits.zip(record_distances).map do |time_limit, record_distance|
    race_possibilities(time_limit).
      select { |_time_held, distance| distance > record_distance }.
      count
  end
end

def margin_of_error
  ways_to_win.reduce(:*)
end

if __FILE__ == $0
  p margin_of_error
end
