import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> cardList;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Stack(
      alignment: Alignment.center,
      children: cardList,
    ));
  }

  @override
  void initState() {
    super.initState();
    cardList = _getMatchCard();
  }

  void _removeCard(index) {
    setState(() {
      cardList.removeAt(index);
    });
  }

  List<Widget> _getMatchCard() {
    List<MatchCard> cards = new List();
    cards.add(MatchCard(255, 0, 0, 10));
    cards.add(MatchCard(0, 255, 0, 20));
    cards.add(MatchCard(0, 0, 255, 30));

    List<Widget> cardList = new List();

    for (int x = 0; x < 3; x++) {
      cardList.add(Positioned(
        top: cards[x].margin,
        child: Draggable(
          onDragEnd: (drag) {
            _removeCard(x);
          },
          childWhenDragging: Container(),
          feedback: Card(
            elevation: 12,
            color: Color.fromARGB(255, cards[x].redColor, cards[x].greenColor,
                cards[x].blueColor),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Container(
              width: 240,
              height: 300,
            ),
          ),
          child: Card(
            elevation: 12,
            color: Color.fromARGB(255, cards[x].redColor, cards[x].greenColor,
                cards[x].blueColor),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Container(
              width: 240,
              height: 300,
            ),
          ),
        ),
      ));
    }

    return cardList;
  }
}

class MatchCard {
  int redColor = 0;
  int greenColor = 0;
  int blueColor = 0;
  double margin = 0;

  MatchCard(this.redColor, this.greenColor, this.blueColor, this.margin);
}
