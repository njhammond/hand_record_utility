require './lib/hand_record_utility.rb'

@board = Hash.new
@board[:north] = "SAKQJT98765432HDC"
@board[:east]  = "SHAKQJT98765432DC"
@board[:south] = "SHDAKQJT98765432C"
@board[:west]  = "SHDCAKQJT98765432"

i = HandRecordUtility.to_pavlicek_number(@board)

puts "i=#{i}"

board = HandRecordUtility.pavlicek_number_to_board(i)
HandRecordUtility.debug_board_short_form(board) 
