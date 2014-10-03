# A hand record/board contains four hands: ":north", ":south", ":west", ":east"
# Each hand is a string[17] in the format
# example hand="SKQH5432DAQJCT954"
# where T=Ten
#
# This gem assumes that the hand record and hand are well formed.
# Little/no error checking on input values.
#
# See http://www.rpbridge.net/7z68.htm for Pavlicek algorithm.
# Richard has given his permission to use the algorithm but with proper attribution.
#
# This algorithm uses 0..D-1, for a UI we use 1..D
#
# See bridge.thomasandrews.com/impossible
# for a web site that displays Pavlicek hands.
#
# We provide routines to go both ways, from a unique number to a hand record,
# from a hand record to a unique number.

require 'combinatorics/choose'

module HandRecordUtility

  # Constants. D is a 29 digit number
  #   22222222221111111111000000000
  #   98765432109876543210987654321
  D = 53644737765488792839237440000
  # Different directions
  DIR_N = 0
  DIR_E = 1
  DIR_S = 2
  DIR_W = 3
  DIRECTIONS = [
    "North",
    "East",
    "South",
    "West",
  ]

  # Using the Ranked order, the order of cards is AS, AH, AD, AC
  # Using the Suited order, the order of cards is AS, KS, QS, ...
  # Always used Ranked
  PAVLICEK_RANKED = 1
  PAVLICEK_SUITED = 2

  # Default is suited
  # Pavlicek web site uses the ranked order, Andrews reference is to the suited order
  # Using Andrews web site to generate the numbers, the suited is preferred.
  # The number is assumed to be 1..D, however the algorithm on Pavlicek's page
  # is 0..D-1. Therefore in a later routine we subtract 1.
  def self.pavlicek_number_to_board(number)
    pavlicek_suited_number_to_board(number)
  end

  # Uses the ranked Pavlicek method
  def self.pavlicek_ranked_number_to_board(number)
    pavlicek_ranked_or_suited_number_to_board(number, PAVLICEK_RANKED)
  end

  # Uses the suited Pavlicek method (default)
  def self.pavlicek_suited_number_to_board(number)
    pavlicek_ranked_or_suited_number_to_board(number, PAVLICEK_SUITED)
  end

  # 1. N=E=S=W=13; C=52; K=D
  # 2. X=K*N/C; If I < X then N=N-1, go to 6
  # 3. I=I-X; X=K*E/C; If I < X then E=E-1, go to 6
  # 4. I=I-X; X=K*S/C; If I < X then S=S-1, go to 6
  # 5. I=I-X; X=K*W/C; W=W-1
  # 6. K=X; C=C-1, loop if not zero to 2
  # Returns a board
  def self.pavlicek_ranked_or_suited_number_to_board(number, ranked_or_suited)
    # Common theme to help with debugging. Define routine name to help with
    # debug. A short routine name. Use a variable to turn debug on or off in the
    # code
    routine_name = "pavlicek_ranked_or_suited_number_to_board"
    short_routine_name = "prsntb"
    debug_routine = 0

    # Error check
    if (number <= 0) then
      puts "Error in #{routine_name}. Invalid number #{number}. Must be 1 or higher."
      return nil
    end

    if (number > HandRecordUtility::D) then
      puts "Error in #{routine_name}. Invalid number #{number} is too big."
      return nil
    end

    # Using variable names from http://www.rpbridge.net/7z68.htm
    n = 13
    e = 13
    s = 13
    w = 13
    c = 52
    k = D
    # hands[NESW][HCDS][0..12 where 0=A, 1=K, 2=Q, ...12=2]
    hands = Array.new(4) { Array.new(4) { Array.new } }

    # The algorithm assumes that the space is 0..D-1
    # But the UI assumes 1..D, so decrement by 1.
    i = number - 1

    (0..51).each do |card_count|
#      if (ranked_or_suited == PAVLICEK_RANKED) then
#        suit = card_count % 4
#        # 0=A, 1=K, 2=Q, .... 12=2
#        rank = (card_count / 4).to_i
#      else
        suit = (card_count / 13).to_i
        # 0=A, 1=K, 2=Q, .... 12=2
        rank = card_count - (suit * 13)
#      end

      # Make sure do it this way and not
      # x = (k / c) * n
      x = (k * n) / c
      if (i < x) then
        n = n - 1
        dir = DIR_N
        if (debug_routine == 1) then
          puts "#{short_routine_name}: dir=#{dir} suit=#{suit} rank=#{rank} i=#{i} x=#{x} n=#{n} e=#{e} s=#{s} w=#{w}"
        end
        hands[dir][suit] << rank
      else
        i = i - x
        x = (k * e) / c
        if (i < x) then
          e = e - 1
          dir = DIR_E
          if (debug_routine == 1) then
            puts "#{short_routine_name}: dir=#{dir} suit=#{suit} rank=#{rank} i=#{i} x=#{x} n=#{n} e=#{e} s=#{s} w=#{w}"
          end
          hands[DIR_E][suit] << rank
        else
          i = i - x
          x = (k * s) / c
          if (i < x) then
            s = s - 1
            dir = DIR_S
            if (debug_routine == 1) then
              puts "#{short_routine_name}: dir=#{dir} suit=#{suit} rank=#{rank} i=#{i} x=#{x} n=#{n} e=#{e} s=#{s} w=#{w}"
            end
            hands[dir][suit] << rank
          else
            # This is West
            i = i - x
            x = (k * w) / c
            if ((i < x) || ((i == 0) && (x == 0))) then
              w = w - 1
              dir = DIR_W
              if (debug_routine == 1) then
                puts "#{short_routine_name}: dir=#{dir} suit=#{suit} rank=#{rank} i=#{i} x=#{x} n=#{n} e=#{e} s=#{s} w=#{w}"
              end
              hands[dir][suit] << rank
            else
              puts "Error. card_count=#{card_count} i=#{i} x=#{x} k=#{k} c=#{c} n=#{n} e=#{e} s=#{s} w=#{w}"
            end
          end
        end
      end
      k = x
      c = c - 1
    end

    if (debug_routine == 1) then
      puts "#{routine_name}: end. n=#{n} e=#{e} s=#{s} w=#{w}"
    end

    return pavlicek_arrays_to_board(hands)
  end

  # pavlicek_arrays_to_board takes four arrays and returns the entire board.
  def self.pavlicek_arrays_to_board(hands)
    board = Hash.new
    board[:north] = pavlicek_array_to_hand(hands[DIR_N])
    board[:east] = pavlicek_array_to_hand(hands[DIR_E])
    board[:south] = pavlicek_array_to_hand(hands[DIR_S])
    board[:west] = pavlicek_array_to_hand(hands[DIR_W])
    return board
  end


  # pav_hand is an array of cards
  # Returns a 17 char string with the hand record.
  def self.pavlicek_array_to_hand(pav_hand_array)
    s = "S" + pavlicek_hand_array_to_suit(pav_hand_array[0])
    s = s + "H" + pavlicek_hand_array_to_suit(pav_hand_array[1])
    s = s + "D" + pavlicek_hand_array_to_suit(pav_hand_array[2])
    s = s + "C" + pavlicek_hand_array_to_suit(pav_hand_array[3])
    return s
  end

  # Given an array holding cards in a suit, return a string with that suit
  def self.pavlicek_hand_array_to_suit(pav_hand_array)
    routine_name = "pavlicek_hand_array_to_suit"
    s = ""
    return s if (pav_hand_array.nil?)

    pav_hand_array.each do |card|
      case card
      when 0
        s = s + "A"
      when 1
        s = s + "K"
      when 2
        s = s + "Q"
      when 3
        s = s + "J"
      when 4
        s = s + "T"
      when 5..12
        c = 14 - card
        s = s + c.to_s
      else
        puts "Invalid value in #{routine_name}. card=#{card}"
        # Error
      end
    end
    return s
  end

  # Converts from a board to a Pavlicek number
  # See http://www.rpbridge.net/7z68.htm
  # Pavlicek ranks the cards in this order:
  # AS, AH, AD, AC, KS.... 2C
  # Algorithm from Richard's web site
  # 1. N=E=S=W=13; C=52; K=D; I=0
  # 2. X=K*N/C; If N card then N=N-1, go to 6
  # 3. I=I+X; X=K*E/C; If E card then E=E-1, go to 6
  # 4. I=I+X; X=K*S/C; If S card then S=S-1, go to 6
  # 5. I=I+X; X=K*W/C; W=W-1
  # 6. K=X; C=C-1, loop if not zero to 2
  def self.to_pavlicek_number(board)
    to_pavlicek_suited_number(board)
  end

  def self.to_pavlicek_suited_number(board)
    routine_name = "to_pavlicek_suited_number"
    debug_routine = 0

    if (debug_routine == 1) then
      puts "#{routine_name}: Board=#{board}"
    end

    pav_array = board_to_pavlicek_array(board, PAVLICEK_SUITED)
#    debug_pavlicek_array(pav_array)
    pav_number = pavlicek_array_to_number(pav_array)
#    debug_pavlicek_array(pav_array)

    return pav_number
  end

  # Given a hand, converts to a Pavlicek array
  def self.to_pavlicek_ranked_number(board)
    routine_name = "to_pavlicek_ranked_number"
    debug_routine = 1

    if (debug_routine == 1) then
      puts "#{routine_name}: Board=#{board}"
    end

    pav_array = board_to_pavlicek_array(board, PAVLICEK_RANKED)
    pav_number = pavlicek_array_to_number(pav_array)
#    debug_pavlicek_array(pav_array)

    return pav_number
  end

  # Given a hand, converts to a Pavlicek array
  # This is a new term I have created.
  # Returns an array [0..51] where 0 is AS, 1 is AH, 2 is AD.... 51 is 2C
  # The values in the array are [0123] (n, e, s, w)
  # In other words, for each card we know which hand it is in
  def self.board_to_pavlicek_array(board, ranked_or_suited)
    # Initialize an array of size 52. Set all values to -1 (as an error check)
    pav_array = Array.new(52, -1)

    put_hand_in_pavlicek_array(pav_array, board[:north], DIR_N, ranked_or_suited)
    put_hand_in_pavlicek_array(pav_array, board[:east], DIR_E, ranked_or_suited)
    put_hand_in_pavlicek_array(pav_array, board[:south], DIR_S, ranked_or_suited)
    put_hand_in_pavlicek_array(pav_array, board[:west], DIR_W, ranked_or_suited)
    # Return the array
    pav_array
  end

  # Given a hand in format "SKQH5432DAQJCT954"
  # Fill out the pavlicek array
  def self.put_hand_in_pavlicek_array(pav_array, hand, direction, ranked_or_suited)
    suit = 0
    hand.each_char do |value|
      if ((value == "S") || (value == "H") || (value == "D") || (value == "C")) then
        case value
        when "S"
          suit = 0
        when "H"
          suit = 1
        when "D"
          suit = 2
        when "C"
          suit = 3
        end
      else
        # We have a card in a suit
        card = 14
        case value
        when "A"
          card_value = 0
        when "K"
          card_value = 1
        when "Q"
          card_value = 2
        when "J"
          card_value = 3
        when "T"
          card_value = 4
        else
          # Map "9" -> 4, "8" -> 5, ... "2" -> 12
          card_value = 62 - value.ord # 50=2, 57=9
#          card_value = 14 - card_int
          if (card_value <= 0) then
            puts "Error in card. card_value=#{card_value} value=#{value}"
          end
        end

        #Error check?
        # AS=0, AH=1, AD=2, AC=3, ... 2C=51
        if (ranked_or_suited == PAVLICEK_RANKED) then
          card = (card_value * 4) + suit
        else
          card = (suit * 13) + card_value
        end
        # card should be 0..51
#        puts "hand=#{hand} value=#{value} card=#{card} direction=#{direction}"
        pav_array[card] = direction
      end
    end
    # No return value
  end

  # Given a Pavlicek array, convert to a number
  # Using variable names from http://www.rpbridge.net/7z68.htm
  def self.pavlicek_array_to_number(pav_array)
    routine_name = "pavlicek_array_to_number"
    debug_routine = 0
    n = 13
    e = 13
    s = 13
    w = 13
    c = 52
    k = D
    i = 0
    card_count = 1

    # Go through the 52 cards
    (0..51).each do |card_count|
      hand_has_card = pav_array[card_count]
      if (debug_routine == 1) then
        # Use a shortened routine name
        puts "pa2n: count=#{card_count} hand_has_card=#{hand_has_card} c=#{c} k=#{k} i=#{i} n=#{n} e=#{e} s=#{s} w=#{w}"
      end

      x = (k * n) / c
      if (hand_has_card == DIR_N) then
        n = n - 1
      else
        i = i + x
        x = (k * e) / c
        if (hand_has_card == DIR_E) then
          e = e - 1
        else
          i = i + x
          x = (k * s) / c
          if (hand_has_card == DIR_S) then
            s = s - 1
          else
            i = i + x
            x = (k * w) / c
            if (hand_has_card == DIR_W) then
              w = w - 1
            else
              # Invalid card
              puts "Invalid direction in HandRecordUtility. count=#{count} value=#{hand_has_card}"
            end
          end
        end
      end

      if (debug_routine == 1) then
        puts "pa2n: end i=#{i} k=#{k} x=#{x} c=#{c} n=#{n} e=#{e} s=#{s} w=#{s}"
      end
      k = x
      c = c - 1
    end

    # The algorithm uses 0..D-1, 
    # The UI uses 1..D so need to increase by 1
    return i + 1
  end

  # Debug utility to print values of the pav_array
  def self.debug_pavlicek_array(pav_array)
    (0..4).each do |tens|
      printf "%2d: ", tens
      (0..9).each do |digit|
        num = (tens * 10) + digit
        printf "%d ", pav_array[num]
      end
      puts "\n"
    end
    printf "%2d: %d %d \n", 5, pav_array[50], pav_array[51]
  end

  # Print a board in short form
  def self.debug_board_short_form(board)
    debug_board_short_form_suit("N", board[:north])
    debug_board_short_form_suit("S", board[:south])
    debug_board_short_form_suit("E", board[:east])
    debug_board_short_form_suit("W", board[:west])
  end

  def self.debug_board_short_form_suit(hand_name, hand)
    puts " #{hand_name}: #{hand}"
  end

  # Print out in format normally associated with cards
  def self.debug_board(board)
    debug_board_ns(board[:north])
    sw = debug_board_hand_suit(board[:west], "S")
    se = debug_board_hand_suit(board[:east], "S")
    printf "S: %-14s S: %s\n", sw, se
    sw = debug_board_hand_suit(board[:west], "H")
    se = debug_board_hand_suit(board[:east], "H")
    printf "H: %-14s H: %s\n", sw, se
    sw = debug_board_hand_suit(board[:west], "D")
    se = debug_board_hand_suit(board[:east], "D")
    printf "D: %-14s D: %s\n", sw, se
    sw = debug_board_hand_suit(board[:west], "C")
    se = debug_board_hand_suit(board[:east], "C")
    printf "C: %-14s C: %s\n", sw, se
    debug_board_ns(board[:south])
  end

  # Prints the North or South hand
  def self.debug_board_ns(hand)
    printf "         S: %s\n", debug_board_hand_suit(hand, "S")
    printf "         H: %s\n", debug_board_hand_suit(hand, "H")
    printf "         D: %s\n", debug_board_hand_suit(hand, "D")
    printf "         C: %s\n", debug_board_hand_suit(hand, "C")
  end

  # Returns the cards in a suit for a hand
  # Assumes hand is well formed
  def self.debug_board_hand_suit(hand, suit)
    s = ""
    case suit
    when "S"
      s = hand[/S.*H/]
      s = s[1, s.length - 2]
    when "H"
      s = hand[/H.*D/]
      s = s[1, s.length - 2]
    when "D"
      s = hand[/D.*C/]
      s = s[1, s.length - 2]
    when "C"
      s = hand[/C.*/]
      s = s[1, s.length - 1]
    end
    return s
  end

  # Convert board to Andrews number.
  # http://bridge.thomasoandrews.com/impossible/algorithm.html

  SMax = Combinatorics::Choose.C(26,13)
  EMax = Combinatorics::Choose.C(39,13)

  def self.pavlicek_array_to_andrews_sequences(pav_array)
    sequences = Array.new( 3 ) { Array.new( 13, -1 ) }
    (0..2).each do |j|    
      count = 0
      loc = 0
      (0..51).each do |i|
        if (j == pav_array[i]) then
          sequences[j][loc] = count
          loc = loc + 1
        end
        if (j <= pav_array[i]) then
          count = count + 1
        end
      end
    end
    sequences
  end

  def self.encode_increasing_sequence(sequence)
    sum = 0
    sequence.each_with_index do |val,index|
      if val > 0 then
#        puts "val=#{val}, index=#{index}"
        # Next line will fail if val=index.
        sum = sum + Combinatorics::Choose.C(val,index+1)
      end
    end
    sum
  end

  def self.to_andrews_number(board)
    pav_array = board_to_pavlicek_array(board, PAVLICEK_RANKED)
    sequences = pavlicek_array_to_andrews_sequences(pav_array)

    seqN = encode_increasing_sequence(sequences[0])
    seqE = encode_increasing_sequence(sequences[1])
    seqS = encode_increasing_sequence(sequences[2])

    return seqS + SMax * (seqE + EMax*seqN)
  end

  def self.decode_to_increasing_sequence(index)
    length = 13
    result = Array.new( length, -1 )

    13.downto(1) do |i|
      last_value = 0
      num = i
      next_value = Combinatorics::Choose.C(num,i)
      while index >= next_value do
        num += 1
        last_value=next_value
        next_value = Combinatorics::Choose.C(num,i)
      end
      result[i-1] = num-1
      index = index - last_value
    end
    result
  end

  # Convert from an Andrews number to a board
  def self.andrews_number_to_board(number)

    s_index = number % SMax
    quotient = number / SMax

    e_index = quotient % EMax
    n_index = quotient / EMax

    north_sequence = decode_to_increasing_sequence(n_index)
    east_sequence = decode_to_increasing_sequence(e_index)
    south_sequence = decode_to_increasing_sequence(s_index)

    # initialize all cards to west since anything missing must be there!

    pav_array = Array.new(52,DIR_W)

    [[north_sequence,DIR_N], 
     [east_sequence,DIR_E],
     [south_sequence,DIR_S]].each do |sequence,direction|
      
      hand_loc = 0
      sequence_loc = 0
      pav_array.each_with_index do |val,idx|
        if (val == DIR_W) then
          if (hand_loc == sequence[sequence_loc]) then
            pav_array[idx] = direction
            sequence_loc = sequence_loc + 1
          end
          hand_loc = hand_loc + 1
        end
      end
    end

    nsew = Array.new(4) { Array.new(4) { Array.new } }
    pav_array.each_with_index do |dir,idx|
      rank = idx / 4
      suit = idx % 4
      nsew[dir][suit].push(rank)
    end

    pavlicek_arrays_to_board(nsew)
  end

end
