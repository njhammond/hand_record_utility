require './lib/hand_record_utility.rb'

#@board = Hash.new
#@board[:north] = "SAKQJT98765432HDC"
#@board[:east]  = "SHAKQJT98765432DC"
#@board[:south] = "SHDAKQJT98765432C"
#@board[:west]  = "SHDCAKQJT98765432"
#
#i = HandRecordUtility.to_pavlicek_number(@board)

#puts "i=#{i}"
i = 1000000000
i = 1234567890123456789012345678
i = 2
i = 23644737765488792839237440009
# board = HandRecordUtility.pavlicek_ranked_number_to_board(i)
board = HandRecordUtility.pavlicek_suited_number_to_board(i)
#HandRecordUtility.debug_board_short_form(board) 
HandRecordUtility.debug_board(board) 
