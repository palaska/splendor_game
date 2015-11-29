:- dynamic cardSlot/2.
:- dynamic deck1/2.
:- dynamic deck2/2.
:- dynamic deck3/2.
:- dynamic nobles/2.

% cards:[id,point,color,white#,blue#,green#,red#,black#]
% ID's correspond to images of the card, so you can use this to fetch the related card.
deck1(initial,[
[1,0,white,0,3,0,0,0,'Images/1.jpg'],
[2,0,white,0,0,0,2,1,'Images/2.jpg'],
[3,0,white,0,1,1,1,1,'Images/3.jpg'],
[4,0,white,0,2,0,0,2,'Images/4.jpg'],
[5,1,white,0,0,4,0,0,'Images/5.jpg'],
[6,0,white,0,1,2,1,1,'Images/6.jpg'],
[7,0,white,0,2,2,0,1,'Images/7.jpg'],
[8,0,white,3,1,0,0,1,'Images/8.jpg'],
[9,0,blue,1,0,0,0,2,'Images/9.jpg'],
[10,0,blue,0,0,0,0,3,'Images/10.jpg'],
[11,0,blue,1,0,1,1,1,'Images/11.jpg'],
[12,0,blue,0,0,2,0,2,'Images/12.jpg'],
[13,1,blue,0,0,0,4,0,'Images/13.jpg'],
[14,0,blue,1,0,1,2,1,'Images/14.jpg'],
[15,0,blue,1,0,2,2,0,'Images/15.jpg'],
[16,0,blue,0,1,3,1,0,'Images/16.jpg'],
[17,0,green,2,1,0,0,0,'Images/17.jpg'],
[18,0,green,0,0,0,3,0,'Images/18.jpg'],
[19,0,green,1,1,0,1,1,'Images/19.jpg'],
[20,0,green,0,2,0,1,0,'Images/20.jpg'],
[21,1,green,0,0,0,0,4,'Images/21.jpg'],
[22,0,green,1,1,0,1,2,'Images/22.jpg'],
[23,0,green,0,1,0,2,2,'Images/23.jpg'],
[24,0,green,1,3,1,0,0,'Images/24.jpg'],
[25,0,red,0,2,1,0,0,'Images/25.jpg'],
[26,0,red,3,0,0,0,0,'Images/26.jpg'],
[27,0,red,1,1,1,0,1,'Images/27.jpg'],
[28,0,red,2,0,0,2,0,'Images/28.jpg'],
[29,1,red,4,0,0,0,0,'Images/29.jpg'],
[30,0,red,2,1,1,0,1,'Images/30.jpg'],
[31,0,red,2,0,1,0,2,'Images/31.jpg'],
[32,0,red,1,0,0,1,3,'Images/32.jpg'],
[33,0,black,0,0,2,1,0,'Images/33.jpg'],
[34,0,black,0,0,3,0,0,'Images/34.jpg'],
[35,0,black,1,1,1,1,0,'Images/35.jpg'],
[36,0,black,2,0,2,0,0,'Images/36.jpg'],
[37,1,black,0,4,0,0,0,'Images/37.jpg'],
[38,0,black,1,2,1,1,0,'Images/38.jpg'],
[39,0,black,2,2,0,1,0,'Images/39.jpg'],
[40,0,black,0,0,1,3,1,'Images/40.jpg']
]).

deck2(initial,[
[101,2,white,0,0,0,5,0,'Images/101.jpg'],
[102,3,white,6,0,0,0,0,'Images/102.jpg'],
[103,1,white,0,0,3,2,2,'Images/103.jpg'],
[104,2,white,0,0,1,4,2,'Images/104.jpg'],
[105,1,white,2,3,0,3,0,'Images/105.jpg'],
[106,2,white,0,0,0,5,3,'Images/106.jpg'],
[107,2,blue,0,5,0,0,0,'Images/107.jpg'],
[108,3,blue,0,6,0,0,0,'Images/108.jpg'],
[109,1,blue,0,2,2,3,0,'Images/109.jpg'],
[110,2,blue,2,0,0,1,4,'Images/110.jpg'],
[111,1,blue,0,2,3,0,3,'Images/111.jpg'],
[112,2,blue,5,3,0,0,0,'Images/112.jpg'],
[113,2,green,0,0,5,0,0,'Images/113.jpg'],
[114,3,green,0,0,6,0,0,'Images/114.jpg'],
[115,1,green,2,3,0,0,2,'Images/115.jpg'],
[116,2,green,3,0,2,3,0,'Images/116.jpg'],
[117,1,green,4,2,0,0,1,'Images/117.jpg'],
[118,2,green,0,5,3,0,0,'Images/118.jpg'],
[119,2,red,0,0,0,0,5,'Images/119.jpg'],
[120,3,red,0,0,0,6,0,'Images/120.jpg'],
[121,1,red,2,0,0,2,3,'Images/121.jpg'],
[122,2,red,1,4,2,0,0,'Images/122.jpg'],
[123,1,red,0,3,0,2,3,'Images/123.jpg'],
[124,2,red,3,0,0,0,5,'Images/124.jpg'],
[125,2,black,5,0,0,0,0,'Images/125.jpg'],
[126,3,black,0,0,0,0,6,'Images/126.jpg'],
[127,1,black,3,2,2,0,0,'Images/127.jpg'],
[128,2,black,0,1,4,2,0,'Images/128.jpg'],
[129,1,black,3,0,3,0,2,'Images/129.jpg'],
[130,2,black,0,0,5,3,0,'Images/130.jpg']
]).

deck3(initial,[
[201,4,white,0,0,0,0,7,'Images/201.jpg'],
[202,5,white,3,0,0,0,7,'Images/202.jpg'],
[203,4,white,3,0,0,3,6,'Images/203.jpg'],
[204,3,white,0,3,3,5,3,'Images/204.jpg'],
[205,4,blue,7,0,0,0,0,'Images/205.jpg'],
[206,5,blue,7,3,0,0,0,'Images/206.jpg'],
[207,4,blue,6,3,0,0,3,'Images/207.jpg'],
[208,3,blue,3,0,3,3,5,'Images/208.jpg'],
[209,4,green,0,7,0,0,0,'Images/209.jpg'],
[210,5,green,0,7,3,0,0,'Images/210.jpg'],
[211,4,green,3,6,3,0,0,'Images/211.jpg'],
[212,3,green,5,3,0,3,3,'Images/212.jpg'],
[213,4,red,0,0,7,0,0,'Images/213.jpg'],
[214,5,red,0,0,7,3,0,'Images/214.jpg'],
[215,4,red,0,3,6,3,0,'Images/215.jpg'],
[216,3,red,3,5,3,0,3,'Images/216.jpg'],
[217,4,black,0,0,0,7,0,'Images/217.jpg'],
[218,5,black,0,0,0,7,3,'Images/218.jpg'],
[219,4,black,0,0,3,6,3,'Images/219.jpg'],
[220,3,black,3,3,5,3,0,'Images/220.jpg']
]).

%nobles:[id,white#,blue#,green#,red#,black#], always 3 points
nobles(initial,[
[501,3,3,0,0,3,'Images/501.jpg'],
[502,0,3,3,3,0,'Images/502.jpg'],
[503,3,0,0,3,3,'Images/503.jpg'],
[504,0,0,4,4,0,'Images/504.jpg'],
[505,0,4,4,0,0,'Images/505.jpg'],
[506,0,0,0,4,4,'Images/506.jpg'],
[507,4,0,0,0,4,'Images/507.jpg'],
[508,3,3,3,0,0,'Images/508.jpg'],
[509,0,0,3,3,3,'Images/509.jpg'],
[510,4,4,0,0,0,'Images/510.jpg']
]).
%first tier cards
cardSlot(1,empty).
cardSlot(2,empty).
cardSlot(3,empty).
cardSlot(4,empty).

%second tier cards
cardSlot(5,empty).
cardSlot(6,empty).
cardSlot(7,empty).
cardSlot(8,empty).

%third tier cards
cardSlot(9,empty).
cardSlot(10,empty).
cardSlot(11,empty).
cardSlot(12,empty).

%nobles cards
cardSlot(13,empty).
cardSlot(14,empty).
cardSlot(15,empty).
cardSlot(16,empty).
cardSlot(17,empty).

%deck cards
cardSlot(18,empty).
cardSlot(19,empty).
cardSlot(20,empty).

readCardSlot(SlotNo, Card) :-
  cardSlot(SlotNo, Card).

setCardSlot(SlotNo, Card) :-
  retractall(cardSlot(SlotNo, _)),
  assert(cardSlot(SlotNo, Card)).

initializeDecks :- shuffleDeck1, shuffleDeck2, shuffleDeck3, shuffleNobles.

shuffleDeck1 :-
  deck1(initial,L),
  shuffle(L, Deck),
  retractall(deck1(initial,_)),
  assert(deck1(shuffled,Deck)).

shuffleDeck2 :-
  deck2(initial,L),
  shuffle(L, Deck),
  retractall(deck2(initial,_)),
  assert(deck2(shuffled,Deck)).

shuffleDeck3 :-
  deck3(initial,L),
  shuffle(L, Deck),
  retractall(deck3(initial,_)),
  assert(deck3(shuffled,Deck)).

shuffleNobles :-
  nobles(initial,L),
  shuffle(L, Deck),
  retractall(nobles(initial,_)),
  assert(nobles(shuffled,Deck)).

% Draw card functions
drawCardDeck1(Card) :-
  deck1(shuffled,Deck),
  length(Deck, L),
  (
    L \= 0,
    [Card|RemainingDeck] = Deck,
    retractall(deck1(shuffled, _)),
    assert(deck1(shuffled, RemainingDeck))
  )
;
  Card = empty.

drawCardDeck2(Card) :-
  deck2(shuffled,Deck),
  length(Deck, L),
  (
    L \= 0,
    [Card|RemainingDeck] = Deck,
    retractall(deck2(shuffled, _)),
    assert(deck2(shuffled, RemainingDeck))
  )
;
  Card = empty.

drawCardDeck3(Card) :-
  deck3(shuffled,Deck),
  length(Deck, L),
  (
    L \= 0,
    [Card|RemainingDeck] = Deck,
    retractall(deck3(shuffled, _)),
    assert(deck3(shuffled, RemainingDeck))
  )
;
  Card = empty.

drawCardNobles(Card) :-
  nobles(shuffled,Deck),
  [Card|RemainingDeck] = Deck,
  retractall(nobles(shuffled, _)),
  assert(nobles(shuffled, RemainingDeck)).


fillCardSlots :-
  forall(between(1, 4, SlotNo),
  (
    drawCardDeck1(Card),
    setCardSlot(SlotNo, Card)
  )
),
forall(between(5, 8, SlotNo),
(
  drawCardDeck2(Card),
  setCardSlot(SlotNo, Card)
)
  ),
  forall(between(9, 12, SlotNo),
  (
    drawCardDeck3(Card),
    setCardSlot(SlotNo, Card)
  )
),
playerCount(PlayerCount),
S is 13 + PlayerCount,
forall(between(13, S, SlotNo),
(
  drawCardNobles(Card),
  setCardSlot(SlotNo, Card)
)
  ),
  setCardSlot(18, [cardBack1,'Images/deck1.jpg']),
  setCardSlot(19, [cardBack2,'Images/deck2.jpg']),
  setCardSlot(20, [cardBack3,'Images/deck3.jpg']).


shuffle([], []).
shuffle(Deck0, [C|Deck]) :-
  random_element(Deck0, C, Deck1),
  shuffle(Deck1, Deck).

random_element(List, Elt, Rest) :-
  length(List, Len),
  Len > 0,
  random(1, Len, Rand),
  select_nth1(Rand, List, Elt, Rest).

random(Lo, Hi, Rand) :-
  Rand is Lo+random(Hi-Lo+1).


select_nth1(N, List, Elt, Rest) :-
  length([_|Front], N), % infinite solutions if N unbound
  append(Front, [Elt|Back], List),
  append(Front, Back, Rest).
