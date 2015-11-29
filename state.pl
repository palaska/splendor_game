%cardPower(mahmut,white,blue,green,red,black).
:- dynamic cardPower/6.

%coinPower(mahmut,white,blue,green,red,black,gold).
:- dynamic coinPower/7.

%prestigePower(mahmut,5).
:- dynamic prestigePower/2.

%cardsReserved(mahmut,2).
:-dynamic cardsReserved/2.

%nobles earned(mahmut,2).
:-dynamic noblesEarned/2.


getTwoPlayerNames(X,Y) :-
  players(L),
  [X|R] = L,
  [Y|_] = R.
getThreePlayerNames(X,Y,Z) :-
  players(L),
  [X|R] = L,
  [Y|R1] = R,
  [Z|_] = R1.
getFourPlayerNames(X,Y,Z,T) :-
  players(L),
  [X|R] = L,
  [Y|R1] = R,
  [Z|R2] = R1,
  [T|_] = R2.


%initialize player powers
initializePowers :-
  playerCount(PlayerCount),
  (
    (
      PlayerCount == 2,
      getTwoPlayerNames(X,Y),
      assert(cardPower(X,0,0,0,0,0)),
      assert(coinPower(X,0,0,0,0,0,0)),
      assert(cardsReserved(X,0)),
      assert(noblesEarned(X,0)),
      assert(prestigePower(X,0)),

      assert(cardPower(Y,0,0,0,0,0)),
      assert(coinPower(Y,0,0,0,0,0,0)),
      assert(cardsReserved(Y,0)),
      assert(noblesEarned(Y,0)),
      assert(prestigePower(Y,0))
    );
    (
      PlayerCount == 3,
      getThreePlayerNames(X,Y,Z),
      assert(cardPower(X,0,0,0,0,0)),
      assert(coinPower(X,0,0,0,0,0,0)),
      assert(cardsReserved(X,0)),
      assert(noblesEarned(X,0)),
      assert(prestigePower(X,0)),

      assert(cardPower(Y,0,0,0,0,0)),
      assert(coinPower(Y,0,0,0,0,0,0)),
      assert(cardsReserved(Y,0)),
      assert(noblesEarned(Y,0)),
      assert(prestigePower(Y,0)),

      assert(cardPower(Z,0,0,0,0,0)),
      assert(coinPower(Z,0,0,0,0,0,0)),
      assert(cardsReserved(Z,0)),
      assert(noblesEarned(Z,0)),
      assert(prestigePower(Z,0))
    );
    (
      PlayerCount == 4,
      getFourPlayerNames(X,Y,Z,T),
      assert(cardPower(X,0,0,0,0,0)),
      assert(coinPower(X,0,0,0,0,0,0)),
      assert(cardsReserved(X,0)),
      assert(prestigePower(X,0)),
      assert(noblesEarned(X,0)),

      assert(cardPower(Y,0,0,0,0,0)),
      assert(coinPower(Y,0,0,0,0,0,0)),
      assert(cardsReserved(Y,0)),
      assert(noblesEarned(Y,0)),
      assert(prestigePower(Y,0)),

      assert(cardPower(Z,0,0,0,0,0)),
      assert(coinPower(Z,0,0,0,0,0,0)),
      assert(cardsReserved(Z,0)),
      assert(noblesEarned(Z,0)),
      assert(prestigePower(Z,0)),

      assert(cardPower(T,0,0,0,0,0)),
      assert(coinPower(T,0,0,0,0,0,0)),
      assert(cardsReserved(T,0)),
      assert(noblesEarned(T,0)),
      assert(prestigePower(T,0))
    )
  ).
