#!/usr/bin/env ruby

require_relative "./advent6.1"

def time_limits
  input.first.join.to_i
end

def record_distances
  input.last.join.to_i
end

if __FILE__ == $0
  p race_possibilities_count(time_limits, record_distances)
end
