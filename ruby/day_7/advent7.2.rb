#!/usr/bin/env ruby

# --- Part Two ---
# To make things a little more interesting, the Elf introduces one additional rule. Now, J cards are jokers - wildcards that can act like whatever card would make the hand the strongest type possible.
#
# To balance this, J cards are now the weakest individual cards, weaker even than 2. The other cards stay in the same order: A, K, Q, T, 9, 8, 7, 6, 5, 4, 3, 2, J.
#
# J cards can pretend to be whatever card is best for the purpose of determining hand type; for example, QJJQ2 is now considered four of a kind. However, for the purpose of breaking ties between two hands of the same type, J is always treated as J, not the card it's pretending to be: JKKK2 is weaker than QQQQ2 because J is weaker than Q.
#
# Now, the above example goes very differently:
#
# 32T3K 765
# T55J5 684
# KK677 28
# KTJJT 220
# QQQJA 483
#
# 32T3K is still the only one pair; it doesn't contain any jokers, so its strength doesn't increase.
# KK677 is now the only two pair, making it the second-weakest hand.
# T55J5, KTJJT, and QQQJA are now all four of a kind! T55J5 gets rank 3, QQQJA gets rank 4, and KTJJT gets rank 5.
#
# With the new joker rule, the total winnings in this example are 5905.
#
# Using the new joker rule, find the rank of every hand in your set. What are the new total winnings?

require_relative "./advent7.1"

class JokerHand < Hand
  private

  def precedence(card)
    %w(J 2 3 4 5 6 7 8 9 T Q K A).index(card)
  end

  def five_of_a_kind
    return 2 ** 6 if cards.uniq.size == 1
    return 2 ** 6 if cards.tally["J"] == 4
    return 2 ** 6 if cards.tally["J"] == 3 && cards.tally.values.include?(2)
    return 2 ** 6 if cards.tally["J"] == 2 && cards.tally.values.include?(3)
    return 2 ** 6 if cards.tally["J"] == 1 && cards.tally.values.include?(4)
    false
  end

  def four_of_a_kind
    return 2 ** 5 if cards.tally.values.include?(4)
    return 2 ** 5 if cards.tally["J"] == 3
    return 2 ** 5 if cards.tally["J"] == 2 && cards.tally.values.sort == [1, 2, 2]
    return 2 ** 5 if cards.tally["J"] == 1 && cards.tally.values.include?(3)
    false
  end

  def full_house
    return 2 ** 4 if cards.tally.values.sort == [2, 3]
    return 2 ** 4 if cards.tally["J"] == 1 && cards.tally.values.sort == [1, 2, 2]
    false
  end

  def three_of_a_kind
    return 2 ** 3 if cards.tally.values.include?(3)
    return 2 ** 3 if cards.tally["J"] == 2
    return 2 ** 3 if cards.tally["J"] == 1 && cards.tally.values.include?(2)
    false
  end

  def two_pairs
    return 2 ** 2 if cards.tally.values.sort == [1, 2, 2]
    return 2 ** 2 if cards.tally["J"] == 1 && cards.tally.values.sort == [1, 1, 1, 2]
    false
  end

  def one_pair
    return 2 ** 1 if cards.tally.values.include?(2)
    return 2 ** 1 if cards.tally["J"] == 1
    false
  end
end

if __FILE__ == $0
  puts winnings(JokerHand)
end
