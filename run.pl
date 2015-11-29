:- include(deck).
:- include(moves).
:- include(coins).
:- include(gui).
:- include(state).
:- include(players).

:- dynamic playerCount/1.
:- dynamic currentPlayer/1.
:- dynamic playerNo/2.


runGame :-
  debug_log_nl,
  debug_log_nl,
  debug_log('---GAME STARTED---'),
  debug_log_nl,
  debug_log('Start Date & Time: '),
  now(Year,Month,Day,Hour,Minute),
  debug_log(Day),
  debug_log('.'),
  debug_log(Month),
  debug_log('.'),
  debug_log(Year),
  debug_log(' '),
  (Hour<10,debug_log('0');true),
  debug_log(Hour),
  debug_log(':'),
  (Minute<10,debug_log('0');true),
  debug_log(Minute),
  debug_log_nl,
  players(L),
  length(L,C),
  assert(playerCount(C)),
  setPlayerNos,
  initializeDecks,
  initializePowers,
  initializeCoins,
  fillCardSlots,
  initializeBoard,
  updateCoinsGUI,
  updatePlayerPowersGUI,
  updateCardSlotsGUI,
  currentPlayer(Cur),
  debug_log(Cur),
  debug_log(' is now playing..'),
  debug_log_nl;
  runGame.



:- dynamic turn/1.
turn(0).

% --------------------------------
% Game end methods
% --------------------------------
:- dynamic endGameTrigger/1.
endGameTrigger(false).


setPlayerNos :-
(
  players(L),
  length(L,A),A\=0,
  [First|R1]=L,
  assert(playerNo(1,First)),
  assert(currentPlayer(First)),
  length(R1,B),B\=0,
  [Second|R2]=R1,
  assert(playerNo(2,Second)),
  length(R2,C),C\=0,
  [Third|R3]=R2,
  assert(playerNo(3,Third)),
  length(R3,D),D\=0,
  [Fourth|R4]=R3,
  assert(playerNo(4,Fourth))
);true.

now(Year,Month,Day,Hour,Minute) :-
    get_time(Stamp),
    stamp_date_time(Stamp, Date, local),
    arg(1,Date,Year),
    arg(2,Date,Month),
    arg(3,Date,Day),
    arg(4,Date,Hour),
    arg(5,Date,Minute).
