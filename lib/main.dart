import 'dart:ffi';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:highlight_text/highlight_text.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Speech to Voice',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: speechScreen(),
    );
  }
}

class speechScreen extends StatefulWidget {
  const speechScreen({Key? key}) : super(key: key);

  @override
  State<speechScreen> createState() => _speechScreenState();
}

class _speechScreenState extends State<speechScreen> {
  stt.SpeechToText spobj = stt.SpeechToText();
  bool isListening = false;
  String text = "Lets get started press the button below";
  double confidenceLevel = 0.9;
  /* @override
  void initState() {
    // TODO: implement initState
    super.initState();
    spobj = stt.SpeechToText();
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
              'Confidence :${(confidenceLevel * 100.0).toStringAsFixed(1)}%'),
          backgroundColor: Colors.green),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        endRadius: 75.0,
        glowColor: Theme.of(context).primaryColor,
        animate: isListening,
        duration: const Duration(milliseconds: 2000),
        repeatPauseDuration: Duration(milliseconds: 100),
        repeat: true,
        child: FloatingActionButton(
          onPressed: () {},
          child: Icon(isListening ? Icons.mic : Icons.mic_none),
        ),
      ),
    );
  }
}
