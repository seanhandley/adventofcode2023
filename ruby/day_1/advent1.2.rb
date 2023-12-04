#!/usr/bin/env ruby

# --- Part Two ---
# Your calculation isn't quite right. It looks like some of the digits are actually spelled out with letters: one, two, three, four, five, six, seven, eight, and nine also count as valid "digits".
#
# Equipped with this new information, you now need to find the real first and last digit on each line. For example:
#
# two1nine
# eightwothree
# abcone2threexyz
# xtwone3four
# 4nineeightseven2
# zoneight234
# 7pqrstsixteen
#
# In this example, the calibration values are 29, 83, 13, 24, 42, 14, and 76. Adding these together produces 281.
#
# What is the sum of all of the calibration values?

def raw_input
  @raw_input ||= STDIN.read
end

def input_a
  raw_input.dup.split("\n").
                map { |line| replace_numbers(line) }.
                map { |line| line.scan(/\d/) }
end

def input_b
  raw_input.dup.split("\n").
                map { |line| replace_numbers_rev(line) }.
                map { |line| line.scan(/\d/) }
end

def numbers_as_text
  {
    "one" => 1, "two" => 2, "three" => 3, "four" => 4, "five" => 5,
    "six" => 6, "seven" => 7, "eight" => 8, "nine" => 9
  }
end

def replace_numbers(line)
  found = false
  line.chars.each_cons(5) do |cons|
    numbers_as_text.each do |word, number|
      if cons.join.include?(word)
        line.sub!(word, number.to_s)
        found = true
        break
      end
    end
    break if found
  end
  found ? replace_numbers(line) : line
end

def replace_numbers_rev(line)
  line.reverse!
  found = false
  line.chars.each_cons(5) do |cons|
    numbers_as_text.each do |word, number|
      if cons.join.include?(word.reverse)
        line.sub!(word.reverse, number.to_s)
        found = true
        break
      end
    end
    break if found
  end
  found ? replace_numbers_rev(line.reverse!) : line.reverse!
end

if __FILE__ == $0
  p input_a.zip(input_b).map { |a, b| "#{a.first}#{b.last}".to_i }.sum
end
