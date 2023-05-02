// ignore_for_file: unused_local_variable

import 'package:curving/core/base/state/base_state.dart';

import 'package:curving/core/components/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../database/word_data.dart';
import 'package:text_to_speech/text_to_speech.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends BaseState<MainPage> {
  List<Map<String, dynamic>> items = [];

  void refreshPage() async {
    final data = await SQLHelper.getItems();
    setState(() {
      items = data;
    });
  }

  void deleteCard(int id) async {
    final db = await SQLHelper.deleteItem(id).then(
      (value) => Fluttertoast.showToast(msg: "Deleted", timeInSecForIosWeb: 3),
    );
  }

  @override
  void initState() {
    refreshPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(top: 10, right: 10, left: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                      ),
                      height: dynamicHeight(0.1),
                      width: dynamicWidth(1),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            items[index]['trText'],
                            style: GoogleFonts.ubuntu(color: whColor),
                          ),
                          Text(" = ", style: GoogleFonts.ubuntu()),
                          Text(
                            items[index]['engText'],
                            style: GoogleFonts.ubuntu(color: whColor),
                          ),
                          IconButton(
                            onPressed: () {
                              tts.setLanguage('en-US');
                              tts.speak(items[index]['engText']);
                            },
                            icon: const Icon(
                              Icons.headphones,
                              color: Colors.black38,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                deleteCard(items[index]['id']);
                              });
                              refreshPage();
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red[400],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  //! TEXT TO SPEECH'S CODES

  TextToSpeech tts = TextToSpeech();
}
