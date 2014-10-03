Hand Record Utility
==

Utility for hand records, primarily for use in Bridge. Can be applied to other games with 4x13 card hands.

This code takes a hand record (4 hands from a Bridge table) and converts it to a unique number using Richard Pavlicek's alogrithm. See http://www.rpbridge.net/7z68.htm for details on Pavlicek's algorithm.

Being extended to include other algorithms, e.g. Thomas Andrews. See http://bridge.thomasoandrews.com/impossible/

Install
==

To install

    git clone https://github.com/njhammond/hand_record_utility
    cd hand_record_utility
    bundle install

Test
==

To test 

    rake

Expect to see 0 failures. There may be some diagnostics about invalid numbers, this is all part of the test. There are also standalone tests in the ```./standalone_tests``` directory.  These contain some of the debug code. Use these for code examples.

Given a unique number, either use the debug tools in this code to display it,
or use Thomas Andrews' web site, 
[http://bridge.thomasoandrews.com/impossible]
(http://bridge.thomasoandrews.com/impossible).

Usage
==

The code is written in Ruby.

The maximum number of deals is HandRecordUtility::D or
53644737765488792839237440000. D is the name that Pavlicek assigns to the maximum number of deals.

To create a random deal, and convert back

```
    i = rand(HandRecordUtility::D) + 1
    board = HandRecordUtility.pavlicek_number_to_board(i)
    HandRecordUtility.to_pavlicek_number(board)
```

Board is a hash with elements, :north, :east, :south, :west.

There are some debug options to pretty print the data.

```
    # Print a short form of a board
    HandRecordUtility.debug_board_short_form(board)
    # Print a hand record of a board
    HandRecordUtility.debug_board(board)
```

To do the same for Andrews numbers

```
    i = rand(HandRecordUtility::D) + 1
    board = HandRecordUtility.andrews_number_to_board(i)
    HandRecordUtility.to_andrews_number(board)
    # Print a short form of a board
    HandRecordUtility.debug_board_short_form(board)
    # Print a hand record of a board
    HandRecordUtility.debug_board(board)
```


Notes
==

Externally the range is 1..D, within the code the range is 0..D-1.

Definitions
==

A hand has 13 cards. A hand record has 4 hands. 

There are 53,644,737,765,488,792,839,237,440,000 possible bridge deals.

Credits
==

Richard Pavlicek has given his approval for use of his algorithm subject to proper accreditiation. Thank you Richard.

Thomas Andrews given his approval for use of his algorithm subject to proper accreditiation. Thank you Thomas.

Purpose
==

The original purpose for putting this code out in the public domain is to try to spur some interest in creating Open Source code that can be used in Bridge projects.

Developers
==

See AUTHORS for list of developers.


License
==

This project uses the MIT-LICENSE.

Please make sure to credit Richard Pavlicek as original author of the algorithm as well.

Please make sure to credit Thomas Andrews as original author of his algorithm.

