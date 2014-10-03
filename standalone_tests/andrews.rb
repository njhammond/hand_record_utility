# Standalone tests of Andrews numbers
#
# Run this from the directory above,
# ruby standalone_tests/andrews.rb
#
require './lib/hand_record_utility.rb'

@board = Hash.new
@board[:north] = "SAKQJT98765432HDC"
@board[:east]  = "SHAKQJT98765432DC"
@board[:south] = "SHDAKQJT98765432C"
@board[:west]  = "SHDCAKQJT98765432"

#i = HandRecordUtility.to_andrews_number(@board)
# 

# This hand above should generate the number 1
# Currently generates 182993471349199361441818250290
#puts "i=#{i}"
# 
#board = HandRecordUtility.andrews_number_to_board(i)
#HandRecordUtility.debug_board_short_form(board) 

i = 1
board = HandRecordUtility.andrews_number_to_board(i)
HandRecordUtility.debug_board_short_form(board) 
HandRecordUtility.debug_board(board) 

# The above works.
# The next line will cause a fault

j = HandRecordUtility.to_andrews_number(@board)
if (i != j) then
  puts "Error. Failed to convert from number<->board i=#{i} j=#{j}"
end

# Use a random 29 digit number for generic board
i = 12345678901234567890123456789
board = HandRecordUtility.andrews_number_to_board(i)
HandRecordUtility.debug_board_short_form(board) 
HandRecordUtility.debug_board(board) 

#  This is the output
#         S: Q843
#         H: 98654
#         D: 32
#         C: A6
#S: T752           S: K9
#H: JT3            H: AQ7
#D: 7              D: QJ98
#C: JT983          C: Q542
#         S: AJ6
#         H: K2
#         D: AKT654
#         C: K7

#j = HandRecordUtility.to_andrews_number(board)
#if (i != j) then
#  puts "Error. Failed to convert from number<->board i=#{i} j=#{j}"
#end

# Also test the maximum
i = HandRecordUtility::D
board = HandRecordUtility.andrews_number_to_board(i)
HandRecordUtility.debug_board_short_form(board) 
HandRecordUtility.debug_board(board) 
