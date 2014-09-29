#require 'test_helper'

# class HandRecordUtility < ActiveSupport::TestCase
class HandRecordUtility < Test::Unit::TestCase
#  test "truth" do
  test "false" do
    assert_kind_of Module, HandRecordUtility
  end

  test "me" do
    board[:north] = "SAKQJT98765432"
    board[:east]  = "HAKQJT98765432"
    board[:south] = "DAKQJT98765432"
    board[:west]  = "CAKQJT98765432"

    i = HandRecordUtility.to_andrews(board)
    puts "i=#{i}"

    board[:north] = "SAKQJT98765432"
    board[:east]  = "DAKQJT98765432"
    board[:south] = "HAKQJT98765432"
    board[:west]  = "CAKQJT98765432"

    i = HandRecordUtility.to_andrews(board)
    puts "i=#{i}"

  end

end
