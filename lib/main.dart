import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'body.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ImagesProvider()),
        ChangeNotifierProvider(create: (_) => placeholder())
      ],
      child: MaterialApp(
        home: Home(),
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageProvider = context.watch<ImagesProvider>();
    void emojiChange() {
      imageProvider.imagesList.shuffle();
      imageProvider.notifyListeners();
    }

    const oneSec = Duration(milliseconds: 800);
    Timer(oneSec, (() => emojiChange()));

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Body(),
      ),
    );
  }
}
