// ignore_for_file: must_be_immutable, file_names, unused_local_variable
import 'package:curving/core/components/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:translator/translator.dart';

class DicPho extends StatefulWidget {
  DicPho({super.key, required this.count, required this.b});
  int count;
  dynamic b;

  @override
  State<DicPho> createState() => _DicPhoState();
}

class _DicPhoState extends State<DicPho> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 3.5,
      child: ListView.builder(
        itemCount: widget.count,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(widget.b!.phonetics[index].audio.toString()),
          );
        },
      ),
    );
  }
}

class DicMea extends StatefulWidget {
  DicMea({super.key, required this.count, required this.b});
  int count;
  dynamic b;

  @override
  State<DicMea> createState() => _DicMeaState();
}

class _DicMeaState extends State<DicMea> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
        itemCount: widget.count,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              widget.b!.meanings.first.definitions[index].definition.toString(),
            ),
          );
        },
      ),
    );
  }
}

class DicWord extends StatefulWidget {
  DicWord({super.key, required this.count, required this.b});
  int count;
  dynamic b;

  @override
  State<DicWord> createState() => _DicWordState();
}

class _DicWordState extends State<DicWord> {
  final player = AudioPlayer();
  String? txt;
  String? def;

  GoogleTranslator translator = GoogleTranslator();

  void translate() async {
    await translator
        .translate(txt ?? " 'Something went wrong!'", to: 'tr')
        .then((value) {
      setState(() {
        txt = value.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 3.5,
      child: ListView.builder(
        itemCount: widget.count,
        itemBuilder: (context, index) {
          return Card(
            shadowColor: orangeColor,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Theme.of(context).colorScheme.outline,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            color: cardColor,
            child: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(
                        widget.b!.word.toString(),
                        style: GoogleFonts.comfortaa(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.play_circle_rounded,
                          size: 40,
                          color: textColor,
                        ),
                        onPressed: () async {
                          if (widget.b!.phonetics.first.audio == null ||
                              widget.b!.phonetics.first.audio.isEmpty) {
                            Fluttertoast.showToast(
                              msg: "No audio recording found :(",
                              timeInSecForIosWeb: 3,
                            );
                          } else {
                            final duration = await player
                                .setUrl("${widget.b!.phonetics.first.audio}");
                            setState(() {
                              player.play();
                            });
                          }
                        },
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            txt = widget.b!.meanings.first.definitions[index]
                                .definition;
                            def = "Tanım: ";
                            translate();
                          });
                        },
                        child: Text(
                          "TR",
                          style: GoogleFonts.comfortaa(
                            fontSize: 18,
                            color: textColor,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  RichText(
                    text: TextSpan(
                      style: GoogleFonts.comfortaa(
                          fontSize: 18, color: Colors.black),
                      children: <TextSpan>[
                        const TextSpan(
                          text: 'Defination : ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text:
                              "${widget.b!.meanings.first.definitions[index].definition}",
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: RichText(
                      text: TextSpan(
                        style: GoogleFonts.comfortaa(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: def,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: txt,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  RichText(
                    text: TextSpan(
                      style: GoogleFonts.comfortaa(
                          fontSize: 18, color: Colors.black),
                      children: <TextSpan>[
                        const TextSpan(
                          text: 'Example : ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text:
                              "${widget.b!.meanings.first.definitions[index].example}",
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  RichText(
                    text: TextSpan(
                      style: GoogleFonts.comfortaa(
                          fontSize: 18, color: Colors.black),
                      children: <TextSpan>[
                        const TextSpan(
                          text: 'Source Url : ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: "${widget.b!.sourceUrls}",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
