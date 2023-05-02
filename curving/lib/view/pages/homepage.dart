import 'package:curving/core/components/colors/colors.dart';
import 'package:curving/view/pages/addCard/add_card_pages.dart';
import 'package:curving/view/pages/main_page.dart';
import 'package:curving/view/pages/search/search_page.dart';
import 'package:curving/view/pages/dictionary.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import '../../core/intl/appbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedPage = 1;

  final pageList = [
    const MainPage(),
    const Translator(),
    const Dictionary(),
    const AddCardPage(),
  ];

  void _indexPage(int index) {
    setState(() {
      selectedPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: bgColor,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: MyAppbar(),
      ),
      bottomNavigationBar: _navBar(),
      body: pageList[selectedPage],
    );
  }

  Widget _navBar() {
    return DotNavigationBar(
      currentIndex: selectedPage,
      onTap: _indexPage,
      backgroundColor: textColor,
      dotIndicatorColor: Colors.white,
      selectedItemColor: orangeColor,
      unselectedItemColor: bgColor,
      items: [
        DotNavigationBarItem(
          icon: const Icon(Icons.home),
        ),
        DotNavigationBarItem(
          icon: const Icon(Icons.search),
        ),
        DotNavigationBarItem(
          icon: const Icon(Icons.book),
        ),
        DotNavigationBarItem(
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}
