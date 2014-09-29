require './lib/hand_record_utility.rb'

output_debug = 0

def test_a_number(i)
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

test_a_number(1)
test_a_number(1000)
test_a_number(1234567890123456789012345678)
test_a_number(HandRecordUtility::D)
# Expect failure
puts "Testing out of bounds. Both should fail."
test_a_number(0)
test_a_number(HandRecordUtility::D + 1)

@board = Hash.new
@board[:north] = "SAKQJT98765432HDC"
@board[:east]  = "SHAKQJT98765432DC"
@board[:south] = "SHDAKQJT98765432C"
@board[:west]  = "SHDCAKQJT98765432"

i = HandRecordUtility.to_pavlicek_number(@board)

board = HandRecordUtility.pavlicek_number_to_board(i)
if (board == @board) then
  puts "Testing with Pavlicek number 1 passed."
else
  puts "Testing with Pavlicek number 1 failed."
end


if (output_debug == 1) then
  puts "Original:"
  HandRecordUtility.debug_board_short_form(@board) 
  puts "New:"
  HandRecordUtility.debug_board_short_form(board) 
  puts "========="
end

@board[:north] = "SHDCAKQJT98765432"
@board[:east]  = "SHDAKQJT98765432C"
@board[:south] = "SHAKQJT98765432DC"
@board[:west]  = "SAKQJT98765432HDC"
i = HandRecordUtility.to_pavlicek_number(@board)

if (output_debug == 1) then
  puts "i=#{i}"

  #board = HandRecordUtility.pavlicek_number_to_board(i)
  #HandRecordUtility.debug_board_short_form(board) 

  puts "========="
end

@board[:north] = "SAJT3HT42DKJ93CA2" # 4342
@board[:east]  = "SKQ92HAKJD876CKQ3" # 4333
@board[:south] = "S865HQ863DATCT984" # 3424
@board[:west]  = "S74H975DQ542CJ765" # 2344
i = HandRecordUtility.to_pavlicek_number(@board)

if (output_debug == 1) then
  puts "i=#{i}"
  puts "Original:"
  HandRecordUtility.debug_board_short_form(@board) 
  board = HandRecordUtility.pavlicek_number_to_board(i)
  puts "New:"
  HandRecordUtility.debug_board_short_form(board) 
end
