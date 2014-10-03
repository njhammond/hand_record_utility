# Standalone tests of Andrews numbers
#
# Run this from the directory above,
# ruby standalone_tests/andrews.rb
#
require './lib/hand_record_utility.rb'

# Module to test converting back and forth
def test_an_andrews_number(i)
  board = HandRecordUtility.andrews_number_to_board(i)
  
  if (board.nil?) then
    puts "Could not create a board for number #{i}."
    return
  end

  j = HandRecordUtility.to_andrews_number(board)
  if (i == j)
    puts "Testing with Andrews number #{i} passed."
  else
    puts "Testing with Andrews number #{i} failed."
  end
end

test_an_andrews_number(1)
test_an_andrews_number(1000)
test_an_andrews_number(1234567890123456789012345678)
test_an_andrews_number(HandRecordUtility::D)
# Expect failure
puts "Testing out of bounds. Both should fail."
test_an_andrews_number(0)
test_an_andrews_number(HandRecordUtility::D + 1)
