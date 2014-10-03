# Standalone tests of conversion of numbers <-> hex
#
# Run this from the directory above,
# ruby standalone_tests/numbers.rb
#
require './lib/hand_record_utility.rb'

# Module to test converting back and forth
def test_hex_to_number(i)
  s = HandRecordUtility.number_to_hex(i)
  j = HandRecordUtility.hex_to_number(s)
  
  if (i == j)
    puts "Converting number from #{i} to 0x#{s} back to integer passed."
  else
    puts "Converting number from #{i} to 0x#{s} back to #{j} failed."
  end
end

test_hex_to_number(1)
test_hex_to_number(1000)
test_hex_to_number(1234567890123456789012345678)
test_hex_to_number(HandRecordUtility::D)
# puts "Testing out of bounds. Both should fail."
test_hex_to_number(0)
test_hex_to_number(HandRecordUtility::D + 1)
