require 'spec_helper'
require 'hand_record_utility'

describe HandRecordUtility do

  # Set up board
  before do
    @board = Hash.new
#    @board[:north] = "SAKQJT98765432"
#    @board[:east]  = "HAKQJT98765432"
#    @board[:south] = "DAKQJT98765432"
#    @board[:west]  = "CAKQJT98765432"
  end

#  it "should generate a board" do
#    pending "do it"
#  end

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
    expect(HandRecordUtility.to_pavlicek_number(@board)).to eq(i)
  end

  ntimes = 10
  it "should test 10 random Pavlicek numbers converting back and forth" do
    (1..ntimes).each do |count|
      i = rand(HandRecordUtility::D) + 1
      @board = HandRecordUtility.pavlicek_number_to_board(i)
#    HandRecordUtility.to_pavlicek_number(@board).should eql i
     expect(HandRecordUtility.to_pavlicek_number(@board)).to eq(i)
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

  # Bounds test - success
  # Same hand record as Pavliceky
  it "should test Andrews number of 1" do
    i = 1
    @board[:north] = "SAKQJT98765432"
    @board[:east]  = "HAKQJT98765432"
    @board[:south] = "DAKQJT98765432"
    @board[:west]  = "CAKQJT98765432"
    expect(HandRecordUtility.to_andrews_number(@board)).to eq(i)
  end

  ntimes = 10
  it "should test 10 random Andrew numbers converting back and forth" do
    (1..ntimes).each do |count|
      i = rand(HandRecordUtility::D) + 1
      @board = HandRecordUtility.andrews_number_to_board(i)
     expect(HandRecordUtility.to_andrews_number(@board)).to eq(i)
    end
  end
end
