import 'package:flutter/material.dart';

//main function is starting point for all flutter apps
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var textformat = TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold);
  var textformatbig = TextStyle(color: Colors.white,fontSize: 45,fontWeight: FontWeight.bold);

  bool whosTurn = true;
  int countero=0;
  int counterx=0;
  int countturns=0;
  List<String> displayExOh = [
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        title: Text('Tic Tac Toe', style: textformat,),
        backgroundColor: Colors.blueGrey,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(//player O
                    children: <Widget>[
                      Text('Player O', style: textformat,),
                      Text(countero.toString(), style: textformat,),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(//player X
                    children: <Widget>[
                      Text('Player X', style: textformat,),
                      Text(counterx.toString(), style: textformat,),
                    ],
                  ),
                ),
              ],
            ),
          ), //player section
          Expanded(
            flex: 3,
            child: GridView.builder(
              itemCount: 9,
              gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    countturns++;
                    _tapped(index);
                  },
                  child: Container(
                    decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                    child: Center(
                      child: Text(displayExOh[index],style: textformatbig,),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: Text(''),
          ), //bottom spacer section
        ],
      ),
    );
  }

  void _tapped(int index) {
    setState(() {
      if (whosTurn) {
        displayExOh[index] = 'O';
      } else {
        displayExOh[index] = 'X';
      }
      whosTurn = !whosTurn;
      _checkWinner();
    });
  }

  void _checkWinner() {
    if (displayExOh[0] == displayExOh[1] && displayExOh[1] == displayExOh[2] && displayExOh[0] != '') {
      _displayWinner(displayExOh[0]);
    }
    if (displayExOh[3] == displayExOh[4] && displayExOh[4] == displayExOh[5] && displayExOh[3] != '') {
      _displayWinner(displayExOh[3]);
    }
    if (displayExOh[6] == displayExOh[7] && displayExOh[7] == displayExOh[8] && displayExOh[6] != '') {
      _displayWinner(displayExOh[6]);
    }
    if (displayExOh[0] == displayExOh[3] && displayExOh[3] == displayExOh[6] && displayExOh[0] != '') {
      _displayWinner(displayExOh[0]);
    }
    if (displayExOh[1] == displayExOh[4] && displayExOh[4] == displayExOh[7] && displayExOh[1] != '') {
      _displayWinner(displayExOh[1]);
    }
    if (displayExOh[2] == displayExOh[5] && displayExOh[5] == displayExOh[8] && displayExOh[2] != '') {
      _displayWinner(displayExOh[2]);
    }
    if (displayExOh[0] == displayExOh[4] && displayExOh[4] == displayExOh[8] && displayExOh[0] != '') {
      _displayWinner(displayExOh[0]);
    }
    if (displayExOh[2] == displayExOh[4] && displayExOh[4] == displayExOh[6] && displayExOh[2] != '') {
      _displayWinner(displayExOh[2]);
    }
    if(countturns==9){
      _displayWinner('No one');
    }
  }
  void _displayWinner(String answer){
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text(answer+' is the winner.'),
            actions: <Widget>[
              FlatButton(
                child: Text('Play Again'),
                onPressed: (){
                  _clearBoard();
                  Navigator.of(context).pop(); //gets rid of prompt when user presses button
                },
              )
            ],
          );
        }
    );
    if(answer=='O'){
      countero++;
    }
    if(answer=='X'){
      counterx++;
    }
  }
  void _clearBoard(){
    setState(() {
      for(int i=0;i<9;i++){
        displayExOh[i]='';
      }
    });
    countturns=0;
  }
}
