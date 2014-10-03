# Standalone tests of Pavlicek numbers
#
# Run this from the directory above,
# ruby standalone_tests/pavlicek.rb
#
require './lib/hand_record_utility.rb'

# Module to test converting back and forth
def test_a_pavlicek_number(i)
  board = HandRecordUtility.pavlicek_number_to_board(i)
  
  if (board.nil?) then
    puts "Could not create a board for number #{i}."
    return
  end

  j = HandRecordUtility.to_pavlicek_number(board)
  if (i == j)
    puts "Testing with Pavlicek number #{i} passed."
  else
    puts "Testing with Pavlicek number #{i} failed."
  end
end

test_a_pavlicek_number(1)
test_a_pavlicek_number(1000)
test_a_pavlicek_number(1234567890123456789012345678)
test_a_pavlicek_number(HandRecordUtility::D)
# Expect failure
puts "Testing out of bounds. Both should fail."
test_a_pavlicek_number(0)
test_a_pavlicek_number(HandRecordUtility::D + 1)
