import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class speechScreen extends StatefulWidget {
  const speechScreen({Key? key}) : super(key: key);

  @override
  State<speechScreen> createState() => _speechScreenState();
}

class _speechScreenState extends State<speechScreen> {
  final Map<String, HighlightedWord> _highlights = {};

  stt.SpeechToText spobj = stt.SpeechToText();
  bool isListening = false;
  String text = "Lets get started press the button below";
  double confidenceLevel = 1.0;
  @override
  void initState() {
    super.initState();
    spobj = stt.SpeechToText();
  }

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
          onPressed: startListen,
          child: Icon(isListening ? Icons.mic : Icons.mic_none),
        ),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Container(
          padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 150.0),
          child: TextHighlight(
            text: text,
            words: _highlights,
            textStyle: const TextStyle(
              fontSize: 32.0,
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }

// logic to start listening and print the speech to screen
  void startListen() async {
    if (!isListening) {
      bool available = await spobj.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() {
          isListening = true;
        });
        spobj.listen(
          onResult: (val) => setState(() {
            text = (val).recognizedWords;
            if (val.hasConfidenceRating && val.confidence > 0) {
              confidenceLevel = val.confidence;
            }
          }),
        );
      } else {
        setState(() {
          isListening = false;
        });
        spobj.stop();
      }
    }
  }
}
