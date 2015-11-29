#How to Run Splendorr!!

1) Enter the names of the players to the "players.pl" file. 2, 3 and 4 players are supported, the board and chip counts will be updated accordingly.

2) Run "run.pl" by typing "swipl run.pl" to the command line or on the SWI Prolog console, by entering the command "consult('run.pl').". Then just type "runGame." and the game will start with the defined players.

3) There is no agent other than human in the code. It is possible to test the frame by playing turn by turn. The command list is provided below. Each command must be ended with a dot (.) in order to be executed.

pickCoin(red,white,blue).  - Use this to pick 3 coins

pickCoin(black,black).  - Use this to pick 2 coins

pickCoin(black).  - You can use this when there is only 1 pile left on the board

buyCard(7).  - Buy the card at the Slot number 7.

reserveCardBoard(7).  - Reserve the card at the Slot number 7.

reserveCardDeck(2).  - Reserve the card from the top of the tier 2 deck.

pass.  - Use this when you want to pass your turn / when you don't have any moves to do.


When you pick coins and exceed the 10 coin limit, the game will ask you to choose the coins to return one by one.
Ex:
?- You must return coin. Color: white.
?- You must return coin. Color: black.


When there are two nobles available to pick in the same turn, the game will ask you to prefer one. If there are 2 available nobles, the options are "1." or "2.". Don't forget to enter the inputs with the following dots(.). The indexing starts from top, so the available noble on the top have the number 1, and others have 2, 3 etc.

