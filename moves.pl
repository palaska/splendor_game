:- dynamic tempGold/1.
:- dynamic tempL/1.
pass  :-
   currentPlayer(Player),
   debug_log(Player),
   debug_log(' passed this round'),
   debug_log_nl,
   debug_log_nl,
   checkNobles,
   prestigePower(Player,Pres),
   ((Pres>=15,retract(endGameTrigger(_)),assert(endGameTrigger(true)),debug_log('This is the final round'),debug_log_nl);true),
     endGameTrigger(FinalRound),
     ((FinalRound==false;FinalRound==true,playerNo(CurPlaNo,Player),playerCount(TotalNoPlayers),CurPlaNo==TotalNoPlayers,debug_log_nl,debug_log('Game ENDED!'),logEndGameStats,halt);true)
  ,updateCoinsGUI,updatePlayerPowersGUI,updateCardSlotsGUI,players([Cur|Rem]),retract(players(_)),append(Rem,[Cur],NewPlayerList),assert(players(NewPlayerList)),retract(currentPlayer(_)),[NewCur|_] = NewPlayerList,assert(currentPlayer(NewCur)),debug_log(NewCur),debug_log(' is now playing..'),debug_log_nl.%,updateIndicatorGUI.%,next turn

buyCard(Slot) :-
(
  currentPlayer(Player),
  playerNo(PlaNoo,Player),
  PlaNoo2 is PlaNoo+6,
  PlaNoo3 is PlaNoo2*3,
  PlaNoo4 is PlaNoo3+3,
  ((Slot > 0,Slot < 13);(Slot>=PlaNoo3,Slot<PlaNoo4)),
  readCardSlot(Slot, Card),
  cardPower(Player,WhiteCard,BlueCard,GreenCard,RedCard,BlackCard),
  coinPower(Player,WhiteCoin,BlueCoin,GreenCoin,RedCoin,BlackCoin,GoldCoin),
  [_,Point,Color,WhiteReq,BlueReq,GreenReq,RedReq,BlackReq,_] = Card,
  (tempGold(IsTempGold),retract(tempGold(_));true),
  assert(tempGold(GoldCoin)),
  (
    (
      tempGold(TempGold1),
      (
        WhiteCard+WhiteCoin >= WhiteReq;
        %gold coin will be used
        (
          NewGoldCoinA is WhiteCard+WhiteCoin-WhiteReq+TempGold1,
          NewGoldCoinA >= 0, retract(tempGold(_)),assert(tempGold(NewGoldCoinA))
        )
      )
    ),
    (
      tempGold(TempGold2),
      (BlueCard+BlueCoin >= BlueReq;
        %gold coin will be used
      (NewGoldCoinB is BlueCard+BlueCoin-BlueReq+TempGold2,
      NewGoldCoinB >= 0, retract(tempGold(_)),assert(tempGold(NewGoldCoinB))))
    ),
    (
      tempGold(TempGold3),
      (GreenCard+GreenCoin >= GreenReq;
        %gold coin will be used
      (NewGoldCoinC is GreenCard+GreenCoin-GreenReq+TempGold3,
      NewGoldCoinC >= 0, retract(tempGold(_)),assert(tempGold(NewGoldCoinC))))
    ),
    (
      tempGold(TempGold4),
      (RedCard+RedCoin >= RedReq;
        %gold coin will be used
      (NewGoldCoinD is RedCard+RedCoin-RedReq+TempGold4,
      NewGoldCoinD >= 0, retract(tempGold(_)),assert(tempGold(NewGoldCoinD))))
    ),
    (
      tempGold(TempGold5),
      (BlackCard+BlackCoin >= BlackReq;
        %gold coin will be used
      (NewGoldCoinE is BlackCard+BlackCoin-BlackReq+TempGold5,
      NewGoldCoinE >= 0, retract(tempGold(_)),assert(tempGold(NewGoldCoinE))))
    )
  ),
  retract(coinPower(Player,_,_,_,_,_,_)),
  (
    (
      WhiteReq > WhiteCard,
      NewWhiteCoinTemp is WhiteCoin-WhiteReq+WhiteCard,
      ((NewWhiteCoinTemp >= 0,NewWhiteCoin is NewWhiteCoinTemp); NewWhiteCoin is 0)
    );
    NewWhiteCoin is WhiteCoin
  ),
  (
    (
      BlueReq > BlueCard,
      NewBlueCoinTemp is BlueCoin-BlueReq+BlueCard,
      ((NewBlueCoinTemp >= 0,NewBlueCoin is NewBlueCoinTemp); NewBlueCoin is 0)
    );
    NewBlueCoin is BlueCoin
  ),
  (
    (
      GreenReq > GreenCard,
      NewGreenCoinTemp is GreenCoin-GreenReq+GreenCard,
      ((NewGreenCoinTemp >= 0,NewGreenCoin is NewGreenCoinTemp); NewGreenCoin is 0)
    );
    NewGreenCoin is BlueCoin
  ),
  (
    (
      RedReq > RedCard,
      NewRedCoinTemp is RedCoin-RedReq+RedCard,
      ((NewRedCoinTemp >= 0,NewRedCoin is NewRedCoinTemp); NewRedCoin is 0)
    );
    NewRedCoin is RedCoin
  ),
  (
    (
      BlackReq > BlackCard,
      NewBlackCoinTemp is BlackCoin-BlackReq+BlackCard,
      ((NewBlackCoinTemp >= 0,NewBlackCoin is NewBlackCoinTemp); NewBlackCoin is 0)
    );
    NewBlackCoin is BlackCoin
  ),
  tempGold(TempGold6),
  assert(coinPower(Player,NewWhiteCoin,NewBlueCoin,NewGreenCoin,NewRedCoin,NewBlackCoin,TempGold6)),
  coin(white,BWhite),
  coin(blue,BBlue),
  coin(green,BGreen),
  coin(red,BRed),
  coin(black,BBlack),
  coin(gold,BGold),
  retractall(coin(_,_)),
  NewWhiteBoardCoin is BWhite+WhiteCoin-NewWhiteCoin,
  NewBlueBoardCoin is BBlue+BlueCoin-NewBlueCoin,
  NewGreenBoardCoin is BGreen+GreenCoin-NewGreenCoin,
  NewRedBoardCoin is BRed+RedCoin-NewRedCoin,
  NewBlackBoardCoin is BBlack+BlackCoin-NewBlackCoin,
  NewGoldBoardCoin is BGold+GoldCoin-TempGold6,
  assert(coin(white,NewWhiteBoardCoin)),
  assert(coin(blue,NewBlueBoardCoin)),
  assert(coin(green,NewGreenBoardCoin)),
  assert(coin(red,NewRedBoardCoin)),
  assert(coin(black,NewBlackBoardCoin)),
  assert(coin(gold,NewGoldBoardCoin)),
  retract(tempGold(_)),
  retract(cardPower(Player,WhiteCard,BlueCard,GreenCard,RedCard,BlackCard)),
  (
    (
      Color == white,
      M is WhiteCard+1,
      assert(cardPower(Player,M,BlueCard,GreenCard,RedCard,BlackCard))
    );
    (
      Color == blue,
      M is BlueCard+1,
      assert(cardPower(Player,WhiteCard,M,GreenCard,RedCard,BlackCard))
    );
    (
      Color == green,
      M is GreenCard+1,
      assert(cardPower(Player,WhiteCard,BlueCard,M,RedCard,BlackCard))
    );
    (
      Color == red,
      M is RedCard+1,
      assert(cardPower(Player,WhiteCard,BlueCard,GreenCard,M,BlackCard))
    );
    (
      Color == black,
      M is BlackCard+1,
      assert(cardPower(Player,WhiteCard,BlueCard,GreenCard,RedCard,M))
    )
  ),
  debug_log(Player),
  debug_log(' has bought a '),
  debug_log(Color),
  debug_log(' development card.'),
  debug_log_nl,
  debug_log('New state of the coins: White:'),
  debug_log(NewWhiteBoardCoin),
  debug_log(', Blue:'),
  debug_log(NewBlueBoardCoin),
  debug_log(', Green:'),
  debug_log(NewGreenBoardCoin),
  debug_log(', Red:'),
  debug_log(NewRedBoardCoin),
  debug_log(', Black:'),
  debug_log(NewBlackBoardCoin),
  debug_log(', Gold:'),
  debug_log(NewGoldBoardCoin),
  debug_log_nl,
  debug_log_nl,
  (
    (
      Slot < 5,
      drawCardDeck1(NewCard),
      (
        (NewCard \= empty,setCardSlot(Slot,NewCard));
        true
      )
    );
    (
      Slot > 4,
      Slot < 9,
      drawCardDeck2(NewCard),
      (
        (NewCard \= empty,setCardSlot(Slot,NewCard));
        true
      )
    );
    (
      Slot > 8,
      Slot < 13,
      (
      drawCardDeck3(NewCard),
      (NewCard \= empty,setCardSlot(Slot,NewCard));
      true
      )
    );
    (
      retractall(cardSlot(Slot,_)),
      cardsReserved(Player,ResCntUpdate),
      NewResCntUpdate is ResCntUpdate-1,
      retractall(cardsReserved(Player,_)),
      assert(cardsReserved(Player,NewResCntUpdate))
    )
  ),
  checkNobles,
   prestigePower(Player,Pres),
   NewPres is Point+Pres,
   retract(prestigePower(Player,_)),
   assert(prestigePower(Player,NewPres)),
   ((NewPres>=15,retract(endGameTrigger(_)),assert(endGameTrigger(true)),debug_log('This is the final round'),debug_log_nl);true),
     endGameTrigger(FinalRound),
     ((FinalRound==false;FinalRound==true,playerNo(CurPlaNo,Player),playerCount(TotalNoPlayers),CurPlaNo==TotalNoPlayers,debug_log_nl,debug_log('Game ENDED!'),logEndGameStats,halt);true)
  ,updateCoinsGUI,updatePlayerPowersGUI,updateCardSlotsGUI,players([Cur|Rem]),retract(players(_)),append(Rem,[Cur],NewPlayerList),assert(players(NewPlayerList)),retract(currentPlayer(_)),[NewCur|_] = NewPlayerList,assert(currentPlayer(NewCur)),debug_log(NewCur),debug_log(' is now playing..'),debug_log_nl%,updateIndicatorGUI%,next turn
);
write(' - invalid move - '). %restart turn

%pick 1 coin when there is only 1 type of the coins left
pickCoin(Color) :-
(
  currentPlayer(Player),
  coinPower(Player,PWhite,PBlue,PGreen,PRed,PBlack,PGold),
  Color\=gold,
  coin(white, White),
  coin(blue, Blue),
  coin(green, Green),
  coin(red, Red),
  coin(black, Black),
  (
    (White >0,Blue==0,Green==0,Red==0,Black==0,Color==white,
      debug_log(Player),debug_log('picks a white coin!'),debug_log_nl,
      retract(coinPower(Player,_,_,_,_,_,_)),
      Added is PWhite+1,
      assert(coinPower(Player,Added,PBlue,PGreen,PRed,PBlack,PGold)),
      retract(coin(white,_)),
      NewCoin is White-1,
      assert(coin(white,NewCoin))
    );
    (White==0,Blue >0,Green==0,Red==0,Black==0,Color==blue,
      debug_log(Player),debug_log('picks a blue coin!'),debug_log_nl,
      retract(coinPower(Player,_,_,_,_,_,_)),
      Added is PBlue+1,
      assert(coinPower(Player,PWhite,Added,PGreen,PRed,PBlack,PGold)),
      retract(coin(blue,_)),
      NewCoin is Blue-1,
      assert(coin(white,NewCoin))
    );
    (White==0,Blue==0,Green >0,Red==0,Black==0,Color==green,
      debug_log(Player),debug_log('picks a green coin!'),debug_log_nl,
      retract(coinPower(Player,_,_,_,_,_,_)),
      Added is PGreen+1,
      assert(coinPower(Player,PWhite,PBlue,Added,PRed,PBlack,PGold)),
      retract(coin(green,_)),
      NewCoin is Green-1,
      assert(coin(green,NewCoin))
    );
    (White==0,Blue==0,Green==0,Red >0,Black==0,Color==red,
      debug_log(Player),debug_log('picks a red coin!'),debug_log_nl,
      retract(coinPower(Player,_,_,_,_,_,_)),
      Added is PRed+1,
      assert(coinPower(Player,PWhite,PBlue,PGreen,Added,PBlack,PGold)),
      retract(coin(red,_)),
      NewCoin is Red-1,
      assert(coin(red,NewCoin))
    );
    (White==0,Blue==0,Green==0,Red==0,Black >0,Color==black,
      debug_log(Player),debug_log('picks a black coin!'),debug_log_nl,
      retract(coinPower(Player,_,_,_,_,_,_)),
      Added is PBlack+1,
      assert(coinPower(Player,PWhite,PBlue,PGreen,PRed,Added,PGold)),
      retract(coin(black,_)),
      NewCoin is Black-1,
      assert(coin(black,NewCoin))
    )
  )%,next turn
  ,checkNobles,
   prestigePower(Player,Pres),
   ((Pres>=15,retract(endGameTrigger(_)),assert(endGameTrigger(true)),debug_log('This is the final round'),debug_log_nl);true)
     ,endGameTrigger(FinalRound),
     ((FinalRound==false;FinalRound==true,playerNo(CurPlaNo,Player),playerCount(TotalNoPlayers),CurPlaNo==TotalNoPlayers,debug_log_nl,debug_log('Game ENDED!'),logEndGameStats,halt);true)
  ,updateCoinsGUI,updatePlayerPowersGUI,updateCardSlotsGUI,checkCoinCnt,
  players([Cur|Rem]),retract(players(_)),append(Rem,[Cur],NewPlayerList),assert(players(NewPlayerList)),retract(currentPlayer(_)),[NewCur|_] = NewPlayerList,assert(currentPlayer(NewCur)),debug_log(NewCur),debug_log(' is now playing..'),debug_log_nl%,updateIndicatorGUI%,next turn
);
  write(' - invalid move - '). %restart turn


%pick 2 coins of same color when there is equal or more than 4 coins of that color / only 2 colors left on the table
pickCoin(Color1, Color2) :-
(
  currentPlayer(Player),
  coinPower(Player,PWhite,PBlue,PGreen,PRed,PBlack,PGold),
  Color1\=gold,
  Color2\=gold,
  (
    (
    Color1 == Color2,coin(Color1,Cnt),Cnt>=4,
    debug_log(Player),debug_log(' picks two '),debug_log(Color1),debug_log(' coins!'),debug_log_nl,
    retract(coinPower(Player,_,_,_,_,_,_)),
    retractall(coin(Color1,_)),
    CntDec is Cnt-2,
    assert(coin(Color1,CntDec)),
    (
      (Color1==white,Added is PWhite+2,
       assert(coinPower(Player,Added,PBlue,PGreen,PRed,PBlack,PGold))
      );
      (Color1==blue,Added is PBlue+2,
       assert(coinPower(Player,PWhite,Added,PGreen,PRed,PBlack,PGold))
      );
      (Color1==green,Added is PGreen+2,
       assert(coinPower(Player,PWhite,PBlue,Added,PRed,PBlack,PGold))
      );
      (Color1==red,Added is PRed+2,
       assert(coinPower(Player,PWhite,PBlue,PGreen,Added,PBlack,PGold))
      );
      (Color1==black,Added is PBlack+2,
       assert(coinPower(Player,PWhite,PBlue,PGreen,PRed,Added,PGold))
      )
    )
    );
    (
    Color1 \= Color2,
    coin(white, White),
    coin(blue, Blue),
    coin(green, Green),
    coin(red, Red),
    coin(black, Black),
    ((White==0,Counter1 is 1);Counter1 is 0,White<4,(Color1==white;Color2==white)),
    ((Blue==0,Counter2 is 1);Counter2 is 0,Blue<4,(Color1==blue;Color2==blue)),
    ((Green==0,Counter3 is 1);Counter3 is 0,Green<4,(Color1==green;Color2==green)),
    ((Red==0,Counter4 is 1);Counter4 is 0,Red<4,(Color1==red;Color2==red)),
    ((Black==0,Counter5 is 1);Counter5 is 0,Black<4,(Color1==black;Color2==black)),
    TotalCounter is Counter1+Counter2+Counter3+Counter4+Counter5,
    TotalCounter == 3,
      (
        (Counter1==0,
         retract(coin(white,_)),
         NewWhiteCoin is White-1,
         assert(coin(white,NewWhiteCoin)),
         coinPower(Player,A1,B1,C1,D1,E1,F1),
         retract(coinPower(Player,_,_,_,_,_,_)),
         AddedWhite is A1+1,
         assert(coinPower(Player,AddedWhite,B1,C1,D1,E1,F1))
        );
        Counter1==1
      ),
      (
        (Counter2==0,
         retract(coin(blue,_)),
         NewBlueCoin is Blue-1,
         assert(coin(blue,NewBlueCoin)),
         coinPower(Player,A2,B2,C2,D2,E2,F2),
         retract(coinPower(Player,_,_,_,_,_,_)),
         AddedBlue is PBlue+1,
         assert(coinPower(Player,A2,AddedBlue,C2,D2,E2,F2))
        );
        Counter2==1
      ),
      (
        (Counter3==0,
         retract(coin(green,_)),
         NewGreenCoin is Green-1,
         assert(coin(green,NewGreenCoin)),
         coinPower(Player,A3,B3,C3,D3,E3,F3),
         retract(coinPower(Player,_,_,_,_,_,_)),
         AddedGreen is PGreen+1,
         assert(coinPower(Player,A3,B3,AddedGreen,D3,E3,F3))
        );
        Counter3==1
      ),
      (
        (Counter4==0,
         retract(coin(red,_)),
         NewRedCoin is Red-1,
         assert(coin(red,NewRedCoin)),
         coinPower(Player,A4,B4,C4,D4,E4,F4),
         retract(coinPower(Player,_,_,_,_,_,_)),
         AddedRed is PRed+1,
         assert(coinPower(Player,A4,B4,C4,AddedRed,E4,F4))
        );
        Counter4==1
      ),
      (
        (Counter5==0,
         retract(coin(black,_)),
         NewBlackCoin is Black-1,
         assert(coin(black,NewBlackCoin)),
         coinPower(Player,A5,B5,C5,D5,E5,F5),
         retract(coinPower(Player,_,_,_,_,_,_)),
         AddedBlack is PBlack+1,
         assert(coinPower(Player,A5,B5,C5,D5,AddedBlack,F5))
        );
        Counter5==1
      )
    )
)%,next turn
  ,checkNobles,
   prestigePower(Player,Pres),
   ((Pres>=15,retract(endGameTrigger(_)),assert(endGameTrigger(true)),debug_log('This is the final round'),debug_log_nl);true)
     ,endGameTrigger(FinalRound),
     ((FinalRound==false;FinalRound==true,playerNo(CurPlaNo,Player),playerCount(TotalNoPlayers),CurPlaNo==TotalNoPlayers,debug_log_nl,debug_log('Game ENDED!'),logEndGameStats,halt);true)
 ,updateCoinsGUI,updatePlayerPowersGUI,updateCardSlotsGUI,checkCoinCnt,players([Cur|Rem]),retract(players(_)),append(Rem,[Cur],NewPlayerList),assert(players(NewPlayerList)),retract(currentPlayer(_)),[NewCur|_] = NewPlayerList,assert(currentPlayer(NewCur)),debug_log(NewCur),debug_log(' is now playing..')%,updateIndicatorGUI%,next turn
);
  write(' - invalid move - '). %restart turn

pickCoin(Color1, Color2, Color3) :-
  (
    currentPlayer(Player),
    coinPower(Player,PWhite,PBlue,PGreen,PRed,PBlack,PGold),
    Color1 \= gold,
    Color2 \= gold,
    Color3 \= gold,
    Color1 \= Color2,
    Color2 \= Color3,
    Color1 \= Color3,
    coin(Color1,Count1),
    coin(Color2,Count2),
    coin(Color3,Count3),
    Count1>0,
    Count2>0,
    Count3>0,
    debug_log(Player),debug_log(' picks up 3 coins: '),debug_log(Color1),debug_log(', '),debug_log(Color2),debug_log(' and '),debug_log(Color3),debug_log('. '),debug_log_nl,debug_log_nl,
    retractall(coin(Color1,_)),
    retractall(coin(Color2,_)),
    retractall(coin(Color3,_)),
    NewCount1 is Count1-1,
    assert(coin(Color1,NewCount1)),
    NewCount2 is Count2-1,
    assert(coin(Color2,NewCount2)),
    NewCount3 is Count3-1,
    assert(coin(Color3,NewCount3)),
    (
      (
        (Color1==white;Color2==white;Color3==white),
         coinPower(Player,A1,B1,C1,D1,E1,F1),
         retract(coinPower(Player,_,_,_,_,_,_)),
         AddedWhite is A1+1,
         assert(coinPower(Player,AddedWhite,B1,C1,D1,E1,F1))
      );
      Color1\=white
    ),
    (
      (
        (Color1==blue;Color2==blue;Color3==blue),
         coinPower(Player,A2,B2,C2,D2,E2,F2),
         retract(coinPower(Player,_,_,_,_,_,_)),
         AddedBlue is B2+1,
         assert(coinPower(Player,A2,AddedBlue,C2,D2,E2,F2))
      );
      Color1\=blue
    ),
    (
      (
        (Color1==green;Color2==green;Color3==green),
         coinPower(Player,A3,B3,C3,D3,E3,F3),
         retract(coinPower(Player,_,_,_,_,_,_)),
         AddedGreen is C3+1,
         assert(coinPower(Player,A3,B3,AddedGreen,D3,E3,F3))
      );
      Color1\=green
    ),
    (
      (
        (Color1==red;Color2==red;Color3==red),
         coinPower(Player,A4,B4,C4,D4,E4,F4),
         retract(coinPower(Player,_,_,_,_,_,_)),
         AddedRed is D4+1,
         assert(coinPower(Player,A4,B4,C4,AddedRed,E4,F4))
      );
      Color1\=red
    ),
    (
      (
        (Color1==black;Color2==black;Color3==black),
         coinPower(Player,A5,B5,C5,D5,E5,F5),
         retract(coinPower(Player,_,_,_,_,_,_)),
         AddedBlack is E5+1,
         assert(coinPower(Player,A5,B5,C5,D5,AddedBlack,F5))
      );
      Color1\=black
    )
  ,checkNobles,
   prestigePower(Player,Pres),
   ((Pres>=15,retract(endGameTrigger(_)),assert(endGameTrigger(true)),debug_log('This is the final round'),debug_log_nl);true)
     ,endGameTrigger(FinalRound),
     ((FinalRound==false;FinalRound==true,playerNo(CurPlaNo,Player),playerCount(TotalNoPlayers),CurPlaNo==TotalNoPlayers,debug_log_nl,debug_log('Game ENDED!'),logEndGameStats,halt);true)
,updateCoinsGUI,updatePlayerPowersGUI,updateCardSlotsGUI,checkCoinCnt,players([Cur|Rem]),retract(players(_)),append(Rem,[Cur],NewPlayerList),assert(players(NewPlayerList)),retract(currentPlayer(_)),[NewCur|_] = NewPlayerList,assert(currentPlayer(NewCur)),debug_log(NewCur),debug_log(' is now playing..'),debug_log_nl%,updateIndicatorGUI%,next turn
  );
  write(' - invalid move - ').



checkCoinCnt :-
  currentPlayer(Player),
  coinPower(Player,Whitee,Bluee,Greenn,Redd,Blackk,Goldd),
(
  Whitee+Bluee+Greenn+Redd+Blackk+Goldd<11;
  (
    (write('You must return coin. Color: '),read(CoinToReturn),
      (
        (CoinToReturn==white,Whitee>0,coin(white,BWhite),IncBoard is BWhite+1,DecCoin is Whitee-1,debug_log(Player),debug_log(' returns a white coin.'),debug_log_nl,retract(coinPower(Player,Whitee,Bluee,Greenn,Redd,Blackk,Goldd)),assert(coinPower(Player,DecCoin,Bluee,Green,Redd,Blackk,Goldd)),retract(coin(white,_)),assert(coin(white,IncBoard)),updateCoinsGUI,updatePlayerPowersGUI
        );
        (CoinToReturn==blue,Bluee>0,coin(blue,BBlue),IncBoard is BBlue+1,DecCoin is Bluee-1,debug_log(Player),debug_log(' returns a blue coin.'),debug_log_nl,retract(coinPower(Player,Whitee,Bluee,Greenn,Redd,Blackk,Goldd)),assert(coinPower(Player,Whitee,DecCoin,Greenn,Redd,Blackk,Goldd)),retract(coin(blue,_)),assert(coin(blue,IncBoard)),updateCoinsGUI,updatePlayerPowersGUI
        );
        (CoinToReturn==green,Greenn>0,coin(green,BGreen),IncBoard is BGreen+1,DecCoin is Greenn-1,debug_log(Player),debug_log(' returns a green coin.'),debug_log_nl,retract(coinPower(Player,Whitee,Bluee,Greenn,Redd,Blackk,Goldd)),assert(coinPower(Player,Whitee,Bluee,DecCoin,Redd,Blackk,Goldd)),retract(coin(green,_)),assert(coin(green,IncBoard)),updateCoinsGUI,updatePlayerPowersGUI
        );
        (CoinToReturn==red,Redd>0,coin(red,BRed),IncBoard is BRedd+1,DecCoin is Redd-1,debug_log(Player),debug_log(' returns a red coin.'),debug_log_nl,retract(coinPower(Player,Whitee,Bluee,Greenn,Redd,Blackk,Goldd)),assert(coinPower(Player,Whitee,Bluee,Green,DecCoin,Blackk,Goldd)),retract(coin(red,_)),assert(coin(red,IncBoard)),updateCoinsGUI,updatePlayerPowersGUI
        );
        (CoinToReturn==black,Blackk>0,coin(black,BBlack),IncBoard is BBlack+1,DecCoin is Blackk-1,debug_log(Player),debug_log(' returns a black coin.'),debug_log_nl,retract(coinPower(Player,Whitee,Bluee,Greenn,Redd,Blackk,Goldd)),assert(coinPower(Player,Whitee,Bluee,Green,Redd,DecCoin,Goldd)),retract(coin(black,_)),assert(coin(black,IncBoard)),updateCoinsGUI,updatePlayerPowersGUI
        );
        (CoinToReturn==gold,Goldd>0,coin(gold,BGold),IncBoard is BGold+1,DecCoin is Goldd-1,debug_log(Player),debug_log(' returns a GOLD coin. OMG!'),retract(coinPower(Player,Whitee,Bluee,Greenn,Redd,Blackk,Goldd)),assert(coinPower(Player,Whitee,Bluee,Green,Redd,Blackk,DecCoin)),retract(coin(gold,_)),assert(coin(gold,IncBoard)),updateCoinsGUI,updatePlayerPowersGUI
        );
        (nl,write('Wrong input, try again..'),nl,checkCoinCnt)
      )
    ),checkCoinCnt
  )
).

checkNobles :-
  (tempL(IsTempL),retract(tempL(_));true),
  assert(tempL([])),
  playerCount(PlayerCount),
  currentPlayer(Player),
  prestigePower(Player,Pres),
  cardPower(Player,White,Blue,Green,Red,Black),
  (
    (PlayerCount==2,
      ((
        readCardSlot(13, Card1),
        [_,WhiteNob1,BlueNob1,GreenNob1,RedNob1,BlackNob1,_] = Card1,
        (
          (White>=WhiteNob1,Blue>=BlueNob1,Green>=GreenNob1,Red>=RedNob1,Black>=BlackNob1,tempL(L1),append(L1,[13],L11),retract(tempL(L1)),assert(tempL(L11)));true
        )
      );true),
      ((
        readCardSlot(14, Card2),
        [_,WhiteNob2,BlueNob2,GreenNob2,RedNob2,BlackNob2,_] = Card2,
        (
          (White>=WhiteNob2,Blue>=BlueNob2,Green>=GreenNob2,Red>=RedNob2,Black>=BlackNob2,tempL(L2),append(L2,[14],L22),retract(tempL(L2)),assert(tempL(L22)));true
        )
      );true),
      ((
        readCardSlot(15, Card3),
        [_,WhiteNob3,BlueNob3,GreenNob3,RedNob3,BlackNob3,_] = Card3,
        (
          (White>=WhiteNob3,Blue>=BlueNob3,Green>=GreenNob3,Red>=RedNob3,Black>=BlackNob3,tempL(L3),append(L3,[15],L33),retract(tempL(L3)),assert(tempL(L33)));true
        )
      );true)
    );
    (PlayerCount==3,
      ((
        readCardSlot(13, Card1),
        [_,WhiteNob1,BlueNob1,GreenNob1,RedNob1,BlackNob1,_] = Card1,
        (
          (White>=WhiteNob1,Blue>=BlueNob1,Green>=GreenNob1,Red>=RedNob1,Black>=BlackNob1,tempL(L1),append(L1,[13],L11),retract(tempL(L1)),assert(tempL(L11)));true
        )
      );true),
      ((
        readCardSlot(14, Card2),
        [_,WhiteNob2,BlueNob2,GreenNob2,RedNob2,BlackNob2,_] = Card2,
        (
          (White>=WhiteNob2,Blue>=BlueNob2,Green>=GreenNob2,Red>=RedNob2,Black>=BlackNob2,tempL(L2),append(L2,[14],L22),retract(tempL(L2)),assert(tempL(L22)));true
        )
      );true),
      ((
        readCardSlot(15, Card3),
        [_,WhiteNob3,BlueNob3,GreenNob3,RedNob3,BlackNob3,_] = Card3,
        (
          (White>=WhiteNob3,Blue>=BlueNob3,Green>=GreenNob3,Red>=RedNob3,Black>=BlackNob3,tempL(L3),append(L3,[15],L33),retract(tempL(L3)),assert(tempL(L33)));true
        )
      );true),
      ((
        readCardSlot(16, Card4),
        [_,WhiteNob4,BlueNob4,GreenNob4,RedNob4,BlackNob4,_] = Card4,
        (
          (White>=WhiteNob4,Blue>=BlueNob4,Green>=GreenNob4,Red>=RedNob4,Black>=BlackNob4,tempL(L4),append(L4,[16],L44),retract(tempL(L4)),assert(tempL(L44)));true
        )
      );true)
    );
    (PlayerCount==4,
      ((
        readCardSlot(13, Card1),
        [_,WhiteNob1,BlueNob1,GreenNob1,RedNob1,BlackNob1,_] = Card1,
        (
          (White>=WhiteNob1,Blue>=BlueNob1,Green>=GreenNob1,Red>=RedNob1,Black>=BlackNob1,tempL(L1),append(L1,[13],L11),retract(tempL(L1)),assert(tempL(L11)));true
        )
      );true),
      ((
        readCardSlot(14, Card2),
        [_,WhiteNob2,BlueNob2,GreenNob2,RedNob2,BlackNob2,_] = Card2,
        (
          (White>=WhiteNob2,Blue>=BlueNob2,Green>=GreenNob2,Red>=RedNob2,Black>=BlackNob2,tempL(L2),append(L2,[14],L22),retract(tempL(L2)),assert(tempL(L22)));true
        )
      );true),
      ((
        readCardSlot(15, Card3),
        [_,WhiteNob3,BlueNob3,GreenNob3,RedNob3,BlackNob3,_] = Card3,
        (
          (White>=WhiteNob3,Blue>=BlueNob3,Green>=GreenNob3,Red>=RedNob3,Black>=BlackNob3,tempL(L3),append(L3,[15],L33),retract(tempL(L3)),assert(tempL(L33)));true
        )
      );true),
      ((
        readCardSlot(16, Card4),
        [_,WhiteNob4,BlueNob4,GreenNob4,RedNob4,BlackNob4,_] = Card4,
        (
          (White>=WhiteNob4,Blue>=BlueNob4,Green>=GreenNob4,Red>=RedNob4,Black>=BlackNob4,tempL(L4),append(L4,[16],L44),retract(tempL(L4)),assert(tempL(L44)));true
        )
      );true),
      ((
        readCardSlot(17, Card5),
        [_,WhiteNob5,BlueNob5,GreenNob5,RedNob5,BlackNob5,_] = Card5,
        (
          (White>=WhiteNob5,Blue>=BlueNob5,Green>=GreenNob5,Red>=RedNob5,Black>=BlackNob5,tempL(L5),append(L5,[17],L55),retract(tempL(L5)),assert(tempL(L55)));true
        )
      );true)
    )
  ),
  tempL(Lfinal),
  length(Lfinal,Len),
  (
    (Len==1,noblesEarned(Player,EarnedNobles),NewEarnedNobles is EarnedNobles+1,retractall(noblesEarned(Player,_)),assert(noblesEarned(Player,NewEarnedNobles)),debug_log('Gratz! '),debug_log(Player),debug_log(' earned a noble!'),debug_log_nl,[Elem|_] = Lfinal,retractall(cardSlot(Elem, _)),retract(prestigePower(Player,_)),NewPres is Pres+3,assert(prestigePower(Player,NewPres)));
    (Len>1,noblesEarned(Player,EarnedNobles),NewEarnedNobles is EarnedNobles+1,retractall(noblesEarned(Player,_)),assert(noblesEarned(Player,NewEarnedNobles)),write('Gratz! There are more than one available noble! Pick one by entering 1, 2.. between available ones.'),nl,read(Index),debug_log(Player),debug_log(' chooses the noble: '),debug_log(Index),debug_log_nl,nth1(Index,Lfinal,Elem),retractall(cardSlot(Elem, _)),retract(prestigePower(Player,_)),NewPres is Pres+3,assert(prestigePower(Player,NewPres)));
    (Len==0);checkNobles
  ),
  updatePlayerPowersGUI,
  updateCardSlotsGUI.


reserveCardBoard(Slot) :-
(
  (Slot > 0,Slot < 13),
  readCardSlot(Slot, Card),
  currentPlayer(Player),
  playerNo(PlayerNo,Player),
  cardsReserved(Player,ResCnt),
  ResCnt<3,
  debug_log(Player),debug_log(' reserves a card, strategic move..'),debug_log_nl,
  NewResCnt is ResCnt+1,
  retract(cardsReserved(Player,_)),
  assert(cardsReserved(Player,NewResCnt)),
  coin(gold,BGold),
  (
    (BGold>0,
    debug_log('He also receives a gold coin!'),debug_log_nl,debug_log_nl,
    coinPower(Player,White,Blue,Green,Red,Black,Gold),
    retract(coinPower(Player,_,_,_,_,_,_)),
    NewGold is Gold+1,
    assert(coinPower(Player,White,Blue,Green,Red,Black,NewGold)),
    retract(coin(gold,_)),
    NewBGold is BGold-1,
    assert(coin(gold,NewBGold)));true
  ),
  PlaNoo2 is PlayerNo+6,
  PlaNoo3 is PlaNoo2*3,
  PlaNoo4 is PlaNoo3+1,
  PlaNoo5 is PlaNoo4+1,
  ( readCardSlot(PlaNoo3,TestRes1) ->
    (readCardSlot(PlaNoo4,TestRes2) -> (readCardSlot(PlaNoo5,TestRes3) -> false; setCardSlot(PlaNoo5,Card)) ; setCardSlot(PlaNoo4,Card)) ;
    setCardSlot(PlaNoo3,Card) ),
  (
    (
      Slot < 5,
      drawCardDeck1(NewCard),
      (
        (NewCard \= empty,setCardSlot(Slot,NewCard));
        true
      )
    );
    (
      Slot > 4,
      Slot < 9,
      drawCardDeck2(NewCard),
      (
        (NewCard \= empty,setCardSlot(Slot,NewCard));
        true
      )
    );
    (
      Slot > 8,
      drawCardDeck3(NewCard),
      (NewCard \= empty,setCardSlot(Slot,NewCard));
      true
    )
  )
  ,checkNobles,
   prestigePower(Player,Pres),
   ((Pres>=15,retract(endGameTrigger(_)),assert(endGameTrigger(true)),debug_log('This is the final round'),debug_log_nl);true)
     ,endGameTrigger(FinalRound),
     ((FinalRound==false;FinalRound==true,playerNo(CurPlaNo,Player),playerCount(TotalNoPlayers),CurPlaNo==TotalNoPlayers,debug_log_nl,debug_log('Game ENDED!'),logEndGameStats,halt);true)
  ,updateCoinsGUI,updatePlayerPowersGUI,updateCardSlotsGUI,checkCoinCnt,
  players([Cur|Rem]),retract(players(_)),append(Rem,[Cur],NewPlayerList),assert(players(NewPlayerList)),retract(currentPlayer(_)),[NewCur|_] = NewPlayerList,assert(currentPlayer(NewCur)),debug_log(NewCur),debug_log(' is now playing..'),debug_log_nl%,updateIndicatorGUI%,next turn
);
  write(' - invalid move - '). %restart turn


reserveCardDeck(DeckNo) :-
(
  (DeckNo > 0,DeckNo < 4),
  (DeckNo==1,drawCardDeck1(Card);true),
  (DeckNo==2,drawCardDeck2(Card);true),
  (DeckNo==3,drawCardDeck3(Card);true),
  Card \= empty,
  currentPlayer(Player),
  playerNo(PlayerNo,Player),
  cardsReserved(Player,ResCnt),
  ResCnt<3,
  debug_log(Player),debug_log(' reserves a card from deck '),debug_log(DeckNo),debug_log_nl,
  NewResCnt is ResCnt+1,
  retract(cardsReserved(Player,_)),
  assert(cardsReserved(Player,NewResCnt)),
  coin(gold,BGold),
  (
    (BGold>0,
    debug_log('He also receives a gold coin!'),debug_log_nl,
    coinPower(Player,White,Blue,Green,Red,Black,Gold),
    retract(coinPower(Player,_,_,_,_,_,_)),
    NewGold is Gold+1,
    assert(coinPower(Player,White,Blue,Green,Red,Black,NewGold)),
    retract(coin(gold,_)),
    NewBGold is BGold-1,
    assert(coin(gold,NewBGold)));true
  ),
  PlaNoo2 is PlayerNo+6,
  PlaNoo3 is PlaNoo2*3,
  PlaNoo4 is PlaNoo3+1,
  PlaNoo5 is PlaNoo4+1,
  ( readCardSlot(PlaNoo3,TestRes1) ->
    (readCardSlot(PlaNoo4,TestRes2) -> (readCardSlot(PlaNoo5,TestRes3) -> false; setCardSlot(PlaNoo5,Card)) ; setCardSlot(PlaNoo4,Card)) ;
    setCardSlot(PlaNoo3,Card) )
  ,checkNobles,
   prestigePower(Player,Pres),
   ((Pres>=15,retract(endGameTrigger(_)),assert(endGameTrigger(true)),debug_log('This is the final round'),debug_log_nl);true)
     ,endGameTrigger(FinalRound),
     ((FinalRound==false;FinalRound==true,playerNo(CurPlaNo,Player),playerCount(TotalNoPlayers),CurPlaNo==TotalNoPlayers,debug_log_nl,debug_log('Game ENDED!'),logEndGameStats,halt);true)
  ,updateCoinsGUI,updatePlayerPowersGUI,updateCardSlotsGUI,checkCoinCnt,
  players([Cur|Rem]),retract(players(_)),append(Rem,[Cur],NewPlayerList),assert(players(NewPlayerList)),retract(currentPlayer(_)),[NewCur|_] = NewPlayerList,assert(currentPlayer(NewCur)),debug_log(NewCur),debug_log(' is now playing..'),debug_log_nl%,updateIndicatorGUI%,next turn
);
  write(' - invalid move - '). %restart turn


debug_status(ok).
debug_log(Message) :- (
						   debug_status(ok), 
               write(Message),
						   open('GameLog.txt', append, Stream),write(Stream, Message),close(Stream)
                      );
            debug_status(nok).	
debug_log_nl :- (
						   debug_status(ok), 
               nl,
						   open('GameLog.txt', append, Stream),nl(Stream),close(Stream)
                      );
            debug_status(nok).	


logEndGameStats :-
  debug_log_nl,
  debug_log('END GAME STATS'),
  debug_log_nl,
  players(L),
  length(L,Len),
  (
    (
      Len==2,
      nth1(1,L,Player1),
      cardPower(Player1,WhiteCard1,BlueCard1,GreenCard1,RedCard1,BlackCard1),
      TotalDev1 is WhiteCard1+BlueCard1+GreenCard1+RedCard1+BlackCard1,
      noblesEarned(Player1,NobCnt1),
      cardsReserved(Player1,CardRes1),
      prestigePower(Player1,Pres1),
      debug_log(Player1),debug_log_nl,debug_log('Total development cards: '),
      debug_log(TotalDev1),debug_log_nl,debug_log('Nobles earned: '),debug_log(NobCnt1),
      debug_log_nl,debug_log('Cards reserved but not bought : '),debug_log(CardRes1),debug_log_nl,
      debug_log('Prestige points: '),debug_log(Pres1),debug_log_nl,debug_log_nl,

      nth1(2,L,Player2),
      cardPower(Player2,WhiteCard2,BlueCard2,GreenCard2,RedCard2,BlackCard2),
      TotalDev2 is WhiteCard2+BlueCard2+GreenCard2+RedCard2+BlackCard2,
      noblesEarned(Player2,NobCnt2),
      cardsReserved(Player2,CardRes2),
      prestigePower(Player2,Pres2),
      debug_log(Player2),debug_log_nl,debug_log('Total development cards: '),
      debug_log(TotalDev2),debug_log_nl,debug_log('Nobles earned: '),debug_log(NobCnt2),
      debug_log_nl,debug_log('Cards reserved but not bought : '),debug_log(CardRes2),debug_log_nl,
      debug_log('Prestige points: '),debug_log(Pres2),debug_log_nl,debug_log_nl,

      PresList=[Pres1,Pres2],
      max_list(PresList, MaxPres),
      findall(X,prestigePower(X,MaxPres),PresWinners),
      length(PresWinners,PresWinnersLen),
      ((PresWinnersLen==1,[OnlyWinner]=PresWinners,debug_log('Winner is '),debug_log(OnlyWinner),debug_log('!!!'),debug_log_nl,debug_log_nl);debug_log('There is a tie in Prestige Points! The fewest development cards wins!! Congratulations!'),debug_log_nl,debug_log_nl)
    );(
      Len==3,
      nth1(1,L,Player1),
      cardPower(Player1,WhiteCard1,BlueCard1,GreenCard1,RedCard1,BlackCard1),
      TotalDev1 is WhiteCard1+BlueCard1+GreenCard1+RedCard1+BlackCard1,
      noblesEarned(Player1,NobCnt1),
      cardsReserved(Player1,CardRes1),
      prestigePower(Player1,Pres1),
      debug_log(Player1),debug_log_nl,debug_log('Total development cards: '),
      debug_log(TotalDev1),debug_log_nl,debug_log('Nobles earned: '),debug_log(NobCnt1),
      debug_log_nl,debug_log('Cards reserved but not bought : '),debug_log(CardRes1),debug_log_nl,
      debug_log('Prestige points: '),debug_log(Pres1),debug_log_nl,debug_log_nl,

      nth1(2,L,Player2),
      cardPower(Player2,WhiteCard2,BlueCard2,GreenCard2,RedCard2,BlackCard2),
      TotalDev2 is WhiteCard2+BlueCard2+GreenCard2+RedCard2+BlackCard2,
      noblesEarned(Player2,NobCnt2),
      cardsReserved(Player2,CardRes2),
      prestigePower(Player2,Pres2),
      debug_log(Player2),debug_log_nl,debug_log('Total development cards: '),
      debug_log(TotalDev2),debug_log_nl,debug_log('Nobles earned: '),debug_log(NobCnt2),
      debug_log_nl,debug_log('Cards reserved but not bought : '),debug_log(CardRes2),debug_log_nl,
      debug_log('Prestige points: '),debug_log(Pres2),debug_log_nl,debug_log_nl,

      nth1(3,L,Player3),
      cardPower(Player3,WhiteCard3,BlueCard3,GreenCard3,RedCard3,BlackCard3),
      TotalDev3 is WhiteCard3+BlueCard3+GreenCard3+RedCard3+BlackCard3,
      noblesEarned(Player3,NobCnt3),
      cardsReserved(Player3,CardRes3),
      prestigePower(Player3,Pres3),
      debug_log(Player3),debug_log_nl,debug_log('Total development cards: '),
      debug_log(TotalDev3),debug_log_nl,debug_log('Nobles earned: '),debug_log(NobCnt3),
      debug_log_nl,debug_log('Cards reserved but not bought : '),debug_log(CardRes3),debug_log_nl,
      debug_log('Prestige points: '),debug_log(Pres3),debug_log_nl,debug_log_nl,

      PresList=[Pres1,Pres2,Pres3],
      max_list(PresList, MaxPres),
      findall(X,prestigePower(X,MaxPres),PresWinners),
      length(PresWinners,PresWinnersLen),
      ((PresWinnersLen==1,[OnlyWinner]=PresWinners,debug_log('Winner is '),debug_log(OnlyWinner),debug_log('!!!'),debug_log_nl,debug_log_nl);debug_log('There is a tie in Prestige Points! The fewest development cards wins!! Congratulations!'),debug_log_nl,debug_log_nl)
    );(
      Len==4,
      nth1(1,L,Player1),
      cardPower(Player1,WhiteCard1,BlueCard1,GreenCard1,RedCard1,BlackCard1),
      TotalDev1 is WhiteCard1+BlueCard1+GreenCard1+RedCard1+BlackCard1,
      noblesEarned(Player1,NobCnt1),
      cardsReserved(Player1,CardRes1),
      prestigePower(Player1,Pres1),
      debug_log(Player1),debug_log_nl,debug_log('Total development cards: '),
      debug_log(TotalDev1),debug_log_nl,debug_log('Nobles earned: '),debug_log(NobCnt1),
      debug_log_nl,debug_log('Cards reserved but not bought : '),debug_log(CardRes1),debug_log_nl,
      debug_log('Prestige points: '),debug_log(Pres1),debug_log_nl,debug_log_nl,

      nth1(2,L,Player2),
      cardPower(Player2,WhiteCard2,BlueCard2,GreenCard2,RedCard2,BlackCard2),
      TotalDev2 is WhiteCard2+BlueCard2+GreenCard2+RedCard2+BlackCard2,
      noblesEarned(Player2,NobCnt2),
      cardsReserved(Player2,CardRes2),
      prestigePower(Player2,Pres2),
      debug_log(Player2),debug_log_nl,debug_log('Total development cards: '),
      debug_log(TotalDev2),debug_log_nl,debug_log('Nobles earned: '),debug_log(NobCnt2),
      debug_log_nl,debug_log('Cards reserved but not bought : '),debug_log(CardRes2),debug_log_nl,
      debug_log('Prestige points: '),debug_log(Pres2),debug_log_nl,debug_log_nl,

      nth1(3,L,Player3),
      cardPower(Player3,WhiteCard3,BlueCard3,GreenCard3,RedCard3,BlackCard3),
      TotalDev3 is WhiteCard3+BlueCard3+GreenCard3+RedCard3+BlackCard3,
      noblesEarned(Player3,NobCnt3),
      cardsReserved(Player3,CardRes3),
      prestigePower(Player3,Pres3),
      debug_log(Player3),debug_log_nl,debug_log('Total development cards: '),
      debug_log(TotalDev3),debug_log_nl,debug_log('Nobles earned: '),debug_log(NobCnt3),
      debug_log_nl,debug_log('Cards reserved but not bought : '),debug_log(CardRes3),debug_log_nl,
      debug_log('Prestige points: '),debug_log(Pres3),debug_log_nl,debug_log_nl,

      nth1(4,L,Player4),
      cardPower(Player4,WhiteCard4,BlueCard4,GreenCard4,RedCard4,BlackCard4),
      TotalDev4 is WhiteCard4+BlueCard4+GreenCard4+RedCard4+BlackCard4,
      noblesEarned(Player4,NobCnt4),
      cardsReserved(Player4,CardRes4),
      prestigePower(Player4,Pres4),
      debug_log(Player4),debug_log_nl,debug_log('Total development cards: '),
      debug_log(TotalDev4),debug_log_nl,debug_log('Nobles earned: '),debug_log(NobCnt4),
      debug_log_nl,debug_log('Cards reserved but not bought : '),debug_log(CardRes4),debug_log_nl,
      debug_log('Prestige points: '),debug_log(Pres4),debug_log_nl,debug_log_nl,

      PresList=[Pres1,Pres2,Pres3,Pres4],
      max_list(PresList, MaxPres),
      findall(X,prestigePower(X,MaxPres),PresWinners),
      length(PresWinners,PresWinnersLen),
      ((PresWinnersLen==1,[OnlyWinner]=PresWinners,debug_log('Winner is '),debug_log(OnlyWinner),debug_log('!!!'),debug_log_nl,debug_log_nl);debug_log('There is a tie in Prestige Points! The fewest development cards wins!! Congratulations!'),debug_log_nl,debug_log_nl)
      )
    ).
