import 'package:flutter/material.dart';
void main(){
  runApp(TicTacToeApp());
}
class TicTacToeApp extends StatelessWidget{
  const TicTacToeApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context){
    return MaterialApp(debugShowCheckedModeBanner:false,home:TicTacToeScreen());
  }
}
class TicTacToeScreen extends StatefulWidget{
  const TicTacToeScreen({Key? key}) : super(key: key);
  @override
  TicTacToeScreenState createState()=>TicTacToeScreenState();
}
class TicTacToeScreenState extends State<TicTacToeScreen>{
  List<String> board=List.filled(9,'');
  bool isXTurn=true;
  String? winner;
  void _handleTap(int index){
    if(board[index]==''&&winner==null){
      setState((){
        board[index]=isXTurn?'X':'O';
        isXTurn=!isXTurn;
        winner=_checkWinner();
      });
    }
  }
  String? _checkWinner(){
    List<List<int>> winningPositions=[[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]];
    for(var pos in winningPositions){
      if(board[pos[0]]!=''&&board[pos[0]]==board[pos[1]]&&board[pos[0]]==board[pos[2]]) {
        return board[pos[0]];
      }
    }
    if(!board.contains('')) return 'Draw';
    return null;
  }
  void _resetGame(){
    setState((){
      board=List.filled(9,'');
      isXTurn=true;
      winner=null;
    });
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar:AppBar(title:Text("Tic Tac Toe")),
        body:SafeArea(
            child:Column(
                mainAxisAlignment:MainAxisAlignment.center,
                children:[
                  Text(
                      winner!=null?(winner=='Draw'?"It's a Draw!":"Winner: $winner"):"Turn: ${isXTurn?'X':'O'}",
                      style:TextStyle(fontSize:24,fontWeight:FontWeight.bold)
                  ),
                  SizedBox(height:20),
                  Expanded(
                      child:GridView.builder(
                          gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:3,childAspectRatio:1.0),
                          itemCount:9,
                          itemBuilder:(context,index) {
                            return GestureDetector(
                                onTap:()=>_handleTap(index),
                                child:Container(
                                    margin:EdgeInsets.all(5),
                                    decoration:BoxDecoration(border:Border.all(color:Colors.black)),
                                    child:Center(child:Text(board[index],style:TextStyle(fontSize:32,fontWeight:FontWeight.bold)))
                                )
                            );
                          }
                      )
                  ),
                  SizedBox(height:20),
                  ElevatedButton(onPressed:_resetGame,child:Text("Restart")),
                  SizedBox(height:20)
                ])
        )
    );
  }
}
