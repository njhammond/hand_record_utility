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

i = HandRecordUtility.to_andrews_number(@board)
# 

# This hand above should generate the number 1
puts "i=#{i}"
# 
board = HandRecordUtility.andrews_number_to_board(i)
HandRecordUtility.debug_board_short_form(board) 
