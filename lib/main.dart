import 'dart:io';
import 'package:flutter/material.dart';
import 'model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Quiz App Simple",
      home: QuizApp(),
    );
  }
}

class QuizApp extends StatefulWidget {
  @override
  QuizAppState createState()=> QuizAppState();
}

class QuizAppState extends State<QuizApp>{

  // Soal bebas dan jawaban A dan B bebas sisanya sih bool itu menentukan jawaban benar atau salah.
  List qList = [
    Quiz("1.Aku itu bisa terbang siapakah aku ....", "A.mobil", "B.Pesawat", false),
    Quiz("2.Aku mempunyai roda 2 saat dinyalakan aku suka mengeluarkan suara brem siapakah aku ...", "A.Motor", "B.Sepeda", true),
    Quiz("3.2 + 8 + 11 = ?", "A.20", "B.21", false),
    Quiz("4.5 - 4 + 2 = ?", "A.3", "B.1", true),
    Quiz("5.Aplikasi untuk membuat video game di android ?", "A.borland c++", "B.android studio", false),
    Quiz("6.8 + 2 = ?", "A.10", "B.12", true),
    Quiz("7.8 * 2 = ?", "A.15", "B.16", false),
    Quiz("8.15 : 5 = ?", "A.3", "B.4", true),
    Quiz("9.Superhero yang bisa terbang menggunakan jubah ?", "A.spiderman", "B.Superman", false),
    Quiz("10.5 + 4 - 4 = ?", "A.5", "B.4", true),
  ];

  var counter = 0;
  var score = 0;

  checkWin(bool userChoice, BuildContext context){
    if(userChoice==qList[counter].isCorrect){
      print("Correct");
      score = score+10;
      final snackbar = SnackBar(
        duration: Duration(milliseconds: 200),
        backgroundColor: Colors.green,
        content: Text("Correct!"),
      );
      Scaffold.of(context).showSnackBar(snackbar);
    }else{
      print("false");
      score = score+0;
      final snackbar = SnackBar(
        duration: Duration(milliseconds : 200),
        backgroundColor: Colors.red,
        content: Text("Incorrect!"),
      );
      Scaffold.of(context).showSnackBar(snackbar);
    }
    setState(() {
      if(counter < 9) {
        counter = counter + 1;
      }else if(counter < 9){
        counter = (counter >= 10) as int;
      }else{
        counter = (counter >= 10) as int;
      }
    });
  }

  Future<void>showScore() async{
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text("Hasil Score Anda"),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(bottom: 15),
                  width: 150,
                  height: 100,
                  child: Text("Score Anda : $score"),
                ),
                Row(
                  children: [
                    TextButton(
                      child: Text("Oke", style: TextStyle(fontSize: 14.0)),
                      onPressed: ()=> Navigator.of(context).pop(),
                    )
                  ],
                ),
              ]
            ),
          ),
        );
      }
    );
  }

  ResetScore(){
    setState(() {
      counter = 0;
      score = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz Belajar Simple", style: TextStyle(fontSize: 16.0),),
        centerTitle: true,
      ),
      body: Builder(
          builder: (BuildContext context)=> SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 20),
            scrollDirection: Axis.vertical,
            child: Column(
              children: <Widget>[
                Padding(padding: const EdgeInsets.all(10.0)),
              Container(
                padding: const EdgeInsets.only(bottom: 30, top: 5),
                width: 180,
                height: 100,
                decoration: BoxDecoration(
                border: Border.all(width: 1.5, color: Colors.black87, style: BorderStyle.solid),
              ),
              child: Text("Quiz Belajar Simple App", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
                ),
                Padding(padding: const EdgeInsets.all(10.0)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                InkWell(
                  child: Text("Hasil Score", style: TextStyle(fontSize: 16.0)),
                  onTap: showScore,
                ),
                InkWell(
                  child: Text("Reset Score", style: TextStyle(fontSize: 16.0)),
                  onTap: ResetScore,
                    ),
                  ],
                ),
                Padding(padding: const EdgeInsets.only(bottom: 30)),
                Container(
                  child: Text(qList[counter].Exercise, style: TextStyle(fontSize: 18.0, fontFamily: "ARIAL",
                  fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,),
                ),
              Padding(padding: EdgeInsets.only(top: 30)),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                RaisedButton(onPressed:()=> checkWin(true, context),
                  padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  child: Text(qList[counter].AnswereA,style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
                  color:  Color.fromRGBO(47, 79, 79, 1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                ),
              ),
            ],
          ),
              Padding(padding: const EdgeInsets.only(bottom: 2.5)),
              Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                RaisedButton(onPressed: ()=> checkWin(false,context),
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                child: Text(qList[counter].AnswereB,style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
                color: Color.fromRGBO(105, 105, 105, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            ListTile(
              title: Text("Exit Game", style: TextStyle(fontSize: 16.0),),
              trailing: Icon(Icons.exit_to_app),
              onTap: ()=> exit(0),
            ),
          ],
        ),
      ),
    );
  }
}