require 'spec_helper'
require 'hand_record_utility'

describe HandRecordUtility do

  # Set up board
  # The format of a hand should be 17 characters, but we can shorten
#    @board[:north] = "SAKQJT98765432"
  # is the same as
#    @board[:north] = "SAKQJT98765432HDC"
  before do
    @board = Hash.new
#    @board[:north] = "SAKQJT98765432"
#    @board[:east]  = "HAKQJT98765432"
#    @board[:south] = "DAKQJT98765432"
#    @board[:west]  = "CAKQJT98765432"
  end

  # Default first test
#  it "should generate a board" do
#    pending "do it"
#  end

  puts "Expect to see error messages. This is part of the tests. Look for number of failures at end"
	puts "Number of failures should be 0."

  ###################
  # Pavlicek tests
  ###################
  # Bounds test - success
  it "should test Pavlicek 1" do
    i = 1
    @board[:north] = "SAKQJT98765432"
    @board[:east]  = "HAKQJT98765432"
    @board[:south] = "DAKQJT98765432"
    @board[:west]  = "CAKQJT98765432"
    expect(HandRecordUtility.to_pavlicek_number(@board)).to eq(i)
  end

  it "should test Pavlicek 12345678901234567890123456789" do
    i = 12345678901234567890123456789
    @board = HandRecordUtility.pavlicek_number_to_board(i)
    expect(HandRecordUtility.to_pavlicek_number(@board)).to eq(i)
  end

  # Test for end
  it "should test Pavlicek 53644737765488792839237440000" do
    # D =53644737765488792839237440000 
    i = HandRecordUtility::D
    @board[:north] = "CAKQJT98765432"
    @board[:east]  = "DAKQJT98765432"
    @board[:south] = "HAKQJT98765432"
    @board[:west]  = "SAKQJT98765432"
    j = HandRecordUtility.to_pavlicek_number(@board)
    expect(j).to eq(i)
  end

  ntimes = 10
  it "should test 10 random Pavlicek numbers converting back and forth" do
    (1..ntimes).each do |count|
      i = rand(HandRecordUtility::D) + 1
      @board = HandRecordUtility.pavlicek_number_to_board(i)
      j = HandRecordUtility.to_pavlicek_number(@board)
      expect(j).to eq(i)
    end
  end

  # Bounds test - failure
  it "should fail with number 0 and print an error message" do
    i = 0
    @board = HandRecordUtility.pavlicek_number_to_board(i)
    expect(@board).to eq(nil)
  end

  it "should fail with number D+1 and print an error message" do
    i = HandRecordUtility::D + 1
    @board = HandRecordUtility.pavlicek_number_to_board(i)
    expect(@board).to eq(nil)
  end

  ###################
  # int<->hex tests
  ###################
  it "should convert 0 to hex 0x0" do
    i = 0
    s = HandRecordUtility.number_to_hex(i)
    expect(s).to eq("0")
    j = HandRecordUtility.hex_to_number(s)
    expect(j).to eq(i)
  end

  it "should convert 1 to hex 0x1" do
    i = 1
    s = HandRecordUtility.number_to_hex(i)
    expect(s).to eq("1")
    j = HandRecordUtility.hex_to_number(s)
    expect(j).to eq(i)
  end

  it "should convert 10 to hex a" do
    i = 10
    s = HandRecordUtility.number_to_hex(i)
    j = HandRecordUtility.hex_to_number(s)
    puts "i=#{i} s=#{s} j=#{j}"
    expect(s).to eq "a"
    expect(j).to eq(i)
  end

  it "should convert 53644737765488792839237440000 to hex 0xad55e315634dda658bf49200" do
    i = 53644737765488792839237440000
    s = HandRecordUtility.number_to_hex(i)
    expect(s).to eq("ad55e315634dda658bf49200")
    j = HandRecordUtility.hex_to_number(s)
    expect(j).to eq(i)
  end

  ntimes = 10
  it "should convert convert 10 random numbers to/from hex" do
    (1..ntimes).each do |count|
      i = rand(HandRecordUtility::D) + 1
      s = HandRecordUtility.number_to_hex(i)
      j = HandRecordUtility.hex_to_number(s)
      expect(j).to eq(i)
    end
  end

  ###################
  # int<->string_64 tests
  ###################
  it "should test all characters to map string 64 format" do
    (0..63).each do |number|
      c = HandRecordUtility::CHAR_TO_BITS[number]
      i = HandRecordUtility.string_64_to_number(c)
      expect(number).to eq(i)
    end
  end

  it "should convert 0 to string 64 0" do
    i = 0
    s = HandRecordUtility.number_to_string_64(i)
    j = HandRecordUtility.string_64_to_number(s)
    expect(s).to eq "0"
    expect(j).to eq(i)
  end

  it "should convert 1 to string 64 1" do
    i = 1
    s = HandRecordUtility.number_to_string_64(i)
    j = HandRecordUtility.string_64_to_number(s)
    expect(s).to eq "1"
    expect(j).to eq(i)
  end

  it "should convert 64 to string 64 40" do
    i = 64
    s = HandRecordUtility.number_to_string_64(i)
    j = HandRecordUtility.string_64_to_number(s)
    expect(s).to eq "10"
    expect(j).to eq(i)
  end

  ntimes = 10
  it "should convert convert 10 random numbers to/from 64 bit string" do
    (1..ntimes).each do |count|
      i = rand(HandRecordUtility::D) + 1
      s = HandRecordUtility.number_to_string_64(i)
      j = HandRecordUtility.string_64_to_number(s)
      expect(j).to eq(i)
    end
  end

  ###################
  # Andrews tests
  ###################
  # 1 is the same hand record for Andrews as Pavlicek
  # Test edge case
  it "should test Andrews number of 1" do
    i = 1
    @board[:north] = "SAKQJT98765432"
    @board[:east]  = "HAKQJT98765432"
    @board[:south] = "DAKQJT98765432"
    @board[:west]  = "CAKQJT98765432"
    j = HandRecordUtility.to_andrews_number(@board)
    expect(j).to eq(i)
  end

  # Test edge case
  it "should test Andrews number of 53644737765488792839237440000" do
    i = 53644737765488792839237440000
    @board[:north] = "CAKQJT98765432"
    @board[:east]  = "DAKQJT98765432"
    @board[:south] = "HAKQJT98765432"
    @board[:west]  = "SAKQJT98765432"
    j = HandRecordUtility.to_andrews_number(@board)
    expect(j).to eq(i)
  end

  # Test random cases
  ntimes = 10
  it "should test 10 random Andrew numbers converting back and forth" do
    (1..ntimes).each do |count|
      i = rand(HandRecordUtility::D) + 1
      @board = HandRecordUtility.andrews_number_to_board(i)
      j = HandRecordUtility.to_andrews_number(@board)
      expect(j).to eq(i)
    end
  end
  #
  # Bounds test - failure
  it "should fail with number 0 and print an error message" do
    i = 0
    @board = HandRecordUtility.andrews_number_to_board(i)
    expect(@board).to eq(nil)
  end

  it "should fail with number D+1 and print an error message" do
    i = HandRecordUtility::D + 1
    @board = HandRecordUtility.andrews_number_to_board(i)
    expect(@board).to eq(nil)
  end

#1: SK5HT93DAT98CAKJ8SJHKQJ7654DJCQ652SQ986H82D642CT943SAT7432HADKQ753C7
#2: SAQ985HT765DJ9CAJSKJT7H9DA8752C865S43HAQJ43DKQ3CQ73S62HK82DT64CKT942
#3: SAQ5H8732D9652C74SKJT32HT9DQTCAK96S764HAQ6DAKJ73CJ8S98HKJ54D84CQT532
  it "should convert from board hash to card array" do

    ["11261300-1", "11261300-2", "11261300-3"].each do |hand_record_number|
      file_name = "standalone_tests/files/card_array/" + hand_record_number + ".txt"
			data = File.read(file_name)
			@board = Hash.new
			@board[:north] = data[ 0,17]
			@board[:east]  = data[17,17]
			@board[:south] = data[34,17]
			@board[:west]  = data[51,17]

      file_name = "standalone_tests/files/card_array/" + hand_record_number + "-e.txt"
			expected_card_array_string = File.read(file_name)
			expected_card_array_string.chomp!

      card_array = HandRecordUtility.board_to_suits(@board)
			card_array_string = card_array.join
      comparison = HandRecordUtility.compare_card_array_string(card_array_string, expected_card_array_string)
      expected = 0
      expect(expected).to eq(comparison)
    end
  end

end
