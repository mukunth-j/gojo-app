// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'dart:async';

// import 'package:flutter/services.dart';
// import 'package:livespeechtotext/livespeechtotext.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();

//   runApp(const MyApp());
// }

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   late Livespeechtotext _livespeechtotextPlugin;
//   late String _recognisedText;
//   String? _localeDisplayName = '';
//   StreamSubscription<dynamic>? onSuccessEvent;

//   bool microphoneGranted = false;

//   @override
//   void initState() {
//     super.initState();
//     _livespeechtotextPlugin = Livespeechtotext();

//     _livespeechtotextPlugin.getLocaleDisplayName().then((value) => setState(
//           () => _localeDisplayName = value,
//         ));

//     _recognisedText = '';
//   }

//   @override
//   void dispose() {
//     onSuccessEvent?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Live Speech To Text'),
//         ),
//         body: Center(
//           child: Column(
//             children: [
//               Text(_recognisedText),
//               if (!microphoneGranted)
//                 ElevatedButton(
//                   onPressed: () {
//                     binding();
//                   },
//                   child: const Text("Check Permissions"),
//                 ),
//               ElevatedButton(
//                   onPressed: microphoneGranted
//                       ? () {
//                           print("start button pressed");
//                           try {
//                             _livespeechtotextPlugin.start();
//                           } on PlatformException {
//                             print('error');
//                           }
//                         }
//                       : null,
//                   child: const Text('Start')),
//               ElevatedButton(
//                   onPressed: microphoneGranted
//                       ? () {
//                           print("stop button pressed");
//                           try {
//                             _livespeechtotextPlugin.stop();
//                           } on PlatformException {
//                             print('error');
//                           }
//                         }
//                       : null,
//                   child: const Text('Stop')),
//               Text("Locale: $_localeDisplayName"),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Future<dynamic> binding() async {
//     onSuccessEvent?.cancel();

//     return Future.wait([]).then((_) async {
//       // Check if the user has already granted microphone permission.
//       // No need for permission checks as the permissions package is removed.

//       return Future.value(true);
//     }).then((value) {
//       microphoneGranted = true;

//       // listen to event "success"
//       onSuccessEvent =
//           _livespeechtotextPlugin.addEventListener("success", (value) {
//         if (value.runtimeType != String) return;
//         if ((value as String).isEmpty) return;

//         setState(() {
//           _recognisedText = value;
//         });
//       });

//       setState(() {});
//     }).onError((error, stackTrace) {
//       // toast
//       log(error.toString());
//       // open app setting
//     });
//   }
// }


// // import 'package:flutter/material.dart';
// // import 'package:speech_to_text/speech_recognition_result.dart';
// // import 'package:speech_to_text/speech_to_text.dart';

// // class SpeechToTextPage extends StatefulWidget {
// //   const SpeechToTextPage({Key? key}) : super(key: key);

// //   @override
// //   _SpeechToTextPage createState() => _SpeechToTextPage();
// // }

// // class _SpeechToTextPage extends State<SpeechToTextPage> {
// //   final TextEditingController _textController = TextEditingController();

// //   final SpeechToText _speechToText = SpeechToText();
// //   bool _speechEnabled = false;
// //   String _lastWords = "";

// //   @override
// //   void initState() {
// //     super.initState();
// //     if (!_speechEnabled) {
// //       _initSpeech();
// //     }
// //   }

// //   /// This has to happen only once per app
// //   void _initSpeech() async {
// //     _speechEnabled = await _speechToText.initialize();
// //   }

// //   /// Each time to start a speech recognition session
// //   void _startListening() async {
// //     await _speechToText.listen(
// //       onResult: _onSpeechResult,
// //       listenFor: const Duration(seconds: 30),
// //       localeId: "en_En",
// //       cancelOnError: false,
// //       partialResults: false,
// //       listenMode: ListenMode.confirmation,
// //     );
// //     setState(() {});
// //   }

// //   /// Manually stop the active speech recognition session
// //   /// Note that there are also timeouts that each platform enforces
// //   /// and the SpeechToText plugin supports setting timeouts on the
// //   /// listen method.
// //   void _stopListening() async {
// //     await _speechToText.stop();
// //     setState(() {});
// //   }

// //   /// This is the callback that the SpeechToText plugin calls when
// //   /// the platform returns recognized words.
// //   void _onSpeechResult(SpeechRecognitionResult result) {
// //     setState(() {
// //       _lastWords = "$_lastWords${result.recognizedWords} ";
// //       _textController.text = _lastWords;
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //         body: Center(
// //       child: ListView(
// //         shrinkWrap: true,
// //         padding: const EdgeInsets.all(12),
// //         children: [
// //           Row(
// //             mainAxisAlignment: MainAxisAlignment.center,
// //             crossAxisAlignment: CrossAxisAlignment.center,
// //             children: [
// //               Expanded(
// //                 child: TextField(
// //                   controller: _textController,
// //                   minLines: 6,
// //                   maxLines: 10,
// //                   decoration: InputDecoration(
// //                     filled: true,
// //                     fillColor: Colors.grey.shade300,
// //                   ),
// //                 ),
// //               ),
// //               const SizedBox(
// //                 width: 8,
// //               ),
// //               FloatingActionButton.small(
// //                 onPressed:
// //                     // If not yet listening for speech start, otherwise stop
// //                     _speechToText.isNotListening
// //                         ? _startListening
// //                         : _stopListening,
// //                 tooltip: 'Listen',
// //                 backgroundColor: Colors.blueGrey,
// //                 child: Icon(
// //                     _speechToText.isNotListening ? Icons.mic_off : Icons.mic),
// //               )
// //             ],
// //           ),
// //         ],
// //       ),
// //     ));
// //   }
// // }
