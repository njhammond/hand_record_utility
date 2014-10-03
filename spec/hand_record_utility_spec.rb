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

end
