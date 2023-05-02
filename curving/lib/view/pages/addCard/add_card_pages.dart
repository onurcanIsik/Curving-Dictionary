import 'package:curving/core/base/state/base_state.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/components/colors/colors.dart';
import '../../../database/word_data.dart';

class AddCardPage extends StatefulWidget {
  const AddCardPage({Key? key}) : super(key: key);

  @override
  State<AddCardPage> createState() => _AddCardPageState();
}

class _AddCardPageState extends BaseState<AddCardPage> {
  Future<void> addCard() async {
    await SQLHelper.createItem(trWord.text, engWord.text).then(
      (value) => Fluttertoast.showToast(msg: "Done !", timeInSecForIosWeb: 2),
    );
  }

  List<Map<String, dynamic>> items = [];

  void refreshPage() async {
    final data = await SQLHelper.getItems();
    setState(() {
      items = data;
    });
  }

  @override
  void initState() {
    super.initState();
    refreshPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 100),
        child: Column(
          children: [
            Form(
              key: formKey,
              child: Column(
                children: [
                  Text(
                    "Add Word",
                    style: GoogleFonts.comfortaa(
                      fontSize: 35,
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  myTrCard(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Divider(
                          color: blColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 5, left: 5),
                        child: Text(
                          "AND",
                          style: GoogleFonts.ubuntu(),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: blColor,
                        ),
                      ),
                    ],
                  ),
                  myEngCard(),
                  SizedBox(
                    width: dynamicWidth(0.4),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: blColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          setState(() {
                            addCard();
                            trWord.clear;
                            engWord.clear;
                          });

                          refreshPage();
                        }
                      },
                      child: Text(
                        "ADD",
                        style: GoogleFonts.ubuntu(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  final formKey = GlobalKey<FormState>();
  TextEditingController trWord = TextEditingController();
  TextEditingController engWord = TextEditingController();

  Widget myTrCard() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: TextFormField(
        maxLength: 12,
        controller: trWord,
        validator: (value) {
          if (value!.isEmpty) {
            return 'cannot be left blank !';
          }
          return null;
        },
        textAlign: TextAlign.center,
        style: GoogleFonts.ubuntu(color: blColor),
        cursorColor: textColor,
        decoration: InputDecoration(
          hintText: "Turkish",
          prefixIcon: Icon(
            Icons.language,
            color: textColor,
          ),
          border: const OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(30),
            ),
            borderSide: BorderSide(color: textColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(30),
            ),
            borderSide: BorderSide(color: textColor),
          ),
        ),
      ),
    );
  }

  Widget myEngCard() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: TextFormField(
        maxLength: 12,
        controller: engWord,
        validator: (value) {
          if (value!.isEmpty) {
            return 'cannot be left blank !';
          }
          return null;
        },
        textAlign: TextAlign.center,
        style: GoogleFonts.ubuntu(color: blColor),
        cursorColor: textColor,
        decoration: InputDecoration(
          hintText: "English",
          prefixIcon: Icon(
            Icons.language,
            color: textColor,
          ),
          border: const OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(30),
            ),
            borderSide: BorderSide(color: textColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(30),
            ),
            borderSide: BorderSide(color: textColor),
          ),
        ),
      ),
    );
  }
}
