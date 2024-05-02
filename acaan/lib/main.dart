import 'dart:math';

import 'package:flutter/material.dart';
import 'package:playing_cards/playing_cards.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Home'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late PlayingCard card;
  bool ifBack=true;
  late TextEditingController _controller;
  String anyNumber='0';

  PlayingCard drawRandomCard(){
    List<Suit> suits=[Suit.spades, Suit.clubs, Suit.diamonds, Suit.hearts];
    List<CardValue> values=CardValue.values;
    Suit randomSuit=suits[Random().nextInt(4)];
    CardValue randomValue=values[Random().nextInt(13)];
    return PlayingCard(
        randomSuit,
        randomValue);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    card=PlayingCard(Suit.spades, CardValue.ace);
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Any Card',
                  style: TextStyle(
                    fontSize: 50,
                  ),
                ),
                SizedBox(
                  height: 300,
                  child: PlayingCardView(
                    card: card,
                    showBack: ifBack,
                  ),
                ),
                ElevatedButton (
                    onPressed: (){
                      setState(() {
                        card=drawRandomCard();
                        ifBack=false;
                      });
                    },
                    child: const Text(
                      '카드 뽑기',
                    ),
                ),
                const SizedBox(
                    height: 50,
                    child: Divider(
                        color: Colors.black,
                        thickness: 1.0),
                ),
                const Text(
                  'Any Number',
                  style: TextStyle(
                    fontSize: 50,
                  ),
                ),
                Text(
                  anyNumber,
                  style: const TextStyle(
                    fontSize: 50,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(
                  width: 70,
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: '최댓값',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                ElevatedButton (
                  onPressed: (){
                    setState(() {
                      anyNumber=(Random().nextInt(int.parse(_controller.text))+1).toString();
                    });
                  },
                  child: const Text(
                    '숫자 뽑기',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
