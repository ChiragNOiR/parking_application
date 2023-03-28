import 'package:flutter/material.dart';
import 'package:parking_app/core/presentation/theme/app_color.dart';
import 'package:flutter_tts/flutter_tts.dart';

class HomeSearchBar extends StatefulWidget {
  const HomeSearchBar({Key? key, this.searchController}) : super(key: key);
  final TextEditingController? searchController;

  @override
  State<HomeSearchBar> createState() => _HomeSearchBarState();
}

enum TtsState { playing, stopped }

class _HomeSearchBarState extends State<HomeSearchBar> {
  late FlutterTts _flutterTts;
  TtsState _ttsState = TtsState.stopped;

  @override
  void initState() {
    super.initState();
    _initializeTts();
  }

  Future<void> _initializeTts() async {
    _flutterTts = FlutterTts();
    // await _flutterTts.setLanguage("en-US");
    // await _flutterTts.setSpeechRate(1.0);
    // await _flutterTts.setPitch(1.0);

    _flutterTts.setStartHandler(() {
      setState(() {
        _ttsState = TtsState.playing;
      });
    });

    _flutterTts.setCompletionHandler(() {
      setState(() {
        _ttsState = TtsState.stopped;
      });
    });

    _flutterTts.setCancelHandler(() {
      setState(() {
        _ttsState = TtsState.stopped;
      });
    });

    _flutterTts.setErrorHandler((message) {
      setState(() {
        _ttsState = TtsState.stopped;
      });
    });
  }

  // Method to start or stop text-to-speech
  Future<void> _toggleTts(String text) async {
    if (_ttsState == TtsState.stopped) {
      await _flutterTts.speak(text);
    } else {
      await _flutterTts.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final FocusNode searchFocusNode = FocusNode();
    searchFocusNode.addListener(() {
      if (searchFocusNode.hasFocus) {
        // show keyboard
        FocusScope.of(context).requestFocus(searchFocusNode);
      } else {
        // hide keyboard
        FocusScope.of(context).unfocus();
      }
    });

    return Container(
      width: 320,
      height: 55,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Color(0xFFE1F2ED),
        borderRadius: BorderRadius.circular(25),
      ),
      child: TextField(
        focusNode: searchFocusNode,
        controller: widget.searchController,
        onChanged: (text) {
          if (_ttsState == TtsState.stopped) {
            _toggleTts(text);
          } else {
            _flutterTts.setCompletionHandler(() {
              _toggleTts(text);
            });
          }
        },
        decoration: InputDecoration(
          hintText: 'Search Your Destination',
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.search,
            color: AppColor.black,
          ),
          suffixIcon: IconButton(
            icon: _ttsState == TtsState.playing
                ? Icon(Icons.stop, color: AppColor.searchIcon)
                : Icon(Icons.mic, color: AppColor.searchIcon),
            onPressed: () {
              if (_ttsState == TtsState.playing) {
                _toggleTts("");
              } else {
                _toggleTts(widget.searchController!.text);
              }
            },
          ),
        ),
      ),
    );
  }
}
