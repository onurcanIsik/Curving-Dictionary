// ignore_for_file: body_might_complete_normally_nullable

import 'package:curving/core/base/state/base_state.dart';
import 'package:curving/core/components/colors/colors.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/Class/myClass.dart';
import '../../../core/base/fetch/Dictionary.dart';

class Translator extends StatefulWidget {
  const Translator({Key? key}) : super(key: key);

  @override
  State<Translator> createState() => _TranslatorState();
}

class _TranslatorState extends BaseState<Translator> {
  Dictionary? dic;
  String? word;
  Future<Dictionary?> fetchData() async {
    final dio = Dio();
    final src = "https://api.dictionaryapi.dev/api/v2/entries/en/$word";
    var response = await dio.get(src);
    if (response.statusCode == 200) {
      dic = Dictionary.fromJson(response.data[0]);
    } else {
      debugPrint("HATA");
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Column(
        children: [
          searchBarView(mySearch()),
          const SizedBox(height: 50),
          Expanded(
            flex: 4,
            child: Container(
              child: dic == null
                  ? const Center(
                      child: Text("Search"),
                    )
                  : DicWord(
                      count: 1,
                      b: dic!,
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget searchBarView(Widget searchBar) {
    return Expanded(
      flex: 1,
      child: Container(
        decoration: BoxDecoration(
          color: blColor,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        height: dynamicHeight(0.1),
        width: dynamicWidth(1),
        child: searchBar,
      ),
    );
  }

  Widget mySearch() {
    TextEditingController wordController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.all(20),
      child: TextFormField(
        controller: wordController,
        style: GoogleFonts.ubuntu(color: whColor),
        cursorColor: textColor,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                word = wordController.text;
                fetchData();
              });
            },
            icon: const Icon(Icons.add_rounded),
          ),
          prefixIcon: Icon(
            Icons.search,
            color: textColor,
          ),
          border: const OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(30),
            ),
            borderSide: BorderSide(color: whColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(30),
            ),
            borderSide: BorderSide(color: whColor),
          ),
        ),
      ),
    );
  }
}
