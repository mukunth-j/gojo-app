import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';

class MyHomePage extends StatefulWidget {
  final double mywidth;

  final double myheight;

  const MyHomePage({super.key, required this.mywidth, required this.myheight});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SpeechToText speechToText = SpeechToText();
  //late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = 'Press the button and start speaking';
  @override
  Widget build(BuildContext context) {
    // double myw = widget.mywidth;
    // double myh = widget.myheight;
    int _userid = 12345678;
    return Scaffold(
      backgroundColor: Image.asset('asstes/images/bg.png').color,
      body: GestureDetector(
        onTapDown: (details) async {
          if (!_isListening) {
            var mya = await SpeechToText().initialize();
            if (mya) {
              setState(() {
                _isListening = true;
                speechToText.listen(onResult: (myr) {
                  setState(() {
                    _text = myr.recognizedWords;
                  });
                });
              });
            }
          }
        },
        onTapUp: (details) {
          setState(() {
            _isListening = false;
          });
          speechToText.stop();
        },
        child: Stack(children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomLeft,
                stops: [0.1, 0.3, 0.6],
                colors: [
                  Color.fromARGB(255, 52, 235, 204),
                  Color.fromARGB(255, 143, 240, 240),
                  Color.fromARGB(255, 199, 243, 243),
                ],
              ),
            ),
          ),
          Positioned(
              top: 0,
              left: -100,
              child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Color(0xD6E7E8).withOpacity(
                        0.5), // Set the color with 50% transparency
                    borderRadius: BorderRadius.all(Radius.elliptical(225, 225)),
                  ))),
          Positioned(
              top: -100,
              left: -40,
              child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Color(0xB3D9D2).withOpacity(
                        0.84), // Set the color with 50% transparency
                    borderRadius: BorderRadius.all(Radius.elliptical(225, 225)),
                  ))),
          Positioned(
              top: 110,
              right: 30,
              //left: myw - 100,
              child: Column(
                children: [
                  Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(217, 217, 217, 1),
                        image: DecorationImage(
                          image: AssetImage('assets/images/user_img.png'),
                          fit: BoxFit.contain,
                        ),
                        shape: BoxShape.circle,
                      )),
                  SizedBox(height: 10),
                  Text(
                    "USER ID : $_userid",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  )
                ],
              )),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    width: 225,
                    height: 225,
                    child: Stack(children: <Widget>[
                      Positioned(
                          top: 15,
                          left: 17,
                          child: Container(
                              width: 190,
                              height: 190,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                    Radius.elliptical(225, 225)),
                              ))),
                      Positioned(
                          top: 22.5,
                          left: 17.250019073486328,
                          child: Container(
                              width: 187.5,
                              height: 178.67648315429688,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(_isListening
                                        ? 'assets/images/rec_status.gif'
                                        : 'assets/images/asset32.png'),
                                    fit: BoxFit.fitWidth),
                              ))),
                    ])),
                Text('Text: $_text'),

                // Text('Confidence: ${(_confidence * 100.0).toStringAsFixed(1)}%'),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
