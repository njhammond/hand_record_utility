Design Notes
==

DUP Format
==

The DUP format is defined at http://www.duplimate.com/DuplimateClub/convert.pdf.

This is the common file format for Duplimante machines.

Each hand is 156 bytes.

  -----------------------------------------------
  |  78 byte BRI    |   68 byte DGE  | 10 bytes |
  -----------------------------------------------

The BRI has 3x13 parts that define the North, East and South hands. Each card is represented in string format, "01" for the sSpade ace, "52" for the club two. "010314" represent the ace, queen of Spades and ace of Hearts. The cards do not need to be sorted.

The DGE has all four hands converted to 17 bytes - 4 suit symbols and 13 cards.

The trailing 10 bytes are (text for URL above):


The last 10 bytes of the DUP-file are needed for the
duplicating process.
Bytes 147 and 148 are either Y or N, denoting yes and no.
Byte 147 gives the answer to question "Random hands?"
Byte 148 tells if it is "Backwards counting".
The three next fields should be left aligned and padded
with space (hex20).
Bytes 149-151 denotes "Lowest board no. in setr",
Bytes 152-153: "Copies of each board"
Bytes 154-156: "Highest board no. in set".

If you have sets of 32, the last 10 bytes should read:
YN1**1*32*.
* = space (hexa 20)

HRF format
==

The HRF format is defined at http://www.duplimate.com/DuplimateClub/convert.pdf

PBN format
==

To do

