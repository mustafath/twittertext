import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ImagesProvider extends ChangeNotifier {
  static double size = 80;

  List imagesList = [
    Image.asset("1.png", width: size, height: size),
    Image.asset("2.png", width: size, height: size),
    Image.asset("3.png", width: size, height: size),
    Image.asset("4.png", width: size, height: size),
    Image.asset("5.png", width: size, height: size),
    Image.asset("6.png", width: size, height: size),
    Image.asset("7.png", width: size, height: size),
    Image.asset("8.png", width: size, height: size),
    Image.asset("9.png", width: size, height: size),
    Image.asset("10.png", width: size, height: size)
  ];
}

class placeholder extends ChangeNotifier {
  Widget placehold = Container();

  void changePlacehold(Widget x) {
    placehold = x;
    notifyListeners();
  }
}

class GridAgain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

final input = TextEditingController();
final emoji = TextEditingController();

class MainScope extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final imageProvider = context.watch<ImagesProvider>();
    final placehold = context.watch<placeholder>();

    late String newText;

    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Container(
          color: Color.fromARGB(255, 255, 172, 199),
          width: double.infinity,
          height: 400,
          child: Column(
            children: [
              Container(
                height: 20,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.center,
                  width: 350,
                  height: 100,
                  color: Color.fromARGB(255, 255, 255, 255),
                  child: TextField(
                      controller: input,
                      maxLines: 4,
                      textAlign: TextAlign.center,
                      autocorrect: false,
                      onSubmitted: (value) => print("hello"),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Buraya metnini gir",
                      )),
                ),
              ),
              Container(height: 20),
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  height: 50,
                  width: 200,
                  color: Colors.white,
                  child: TextField(
                      controller: emoji,
                      maxLines: 4,
                      textAlign: TextAlign.center,
                      autocorrect: false,
                      onSubmitted: (value) => print("hello"),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Emojini seç",
                      )),
                ),
              ),
              Container(
                height: 20,
              ),
              GestureDetector(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                        alignment: Alignment.center,
                        color: Colors.white,
                        width: 100,
                        height: 30,
                        child: Text("Oluştur"))),
                onTap: input.text == '' && emoji.text == ''
                    ? null
                    : () {
                        newText = input.text.replaceAll(" ", emoji.text);
                        print(newText);
                        placehold.placehold = ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Container(
                                alignment: Alignment.center,
                                height: 100,
                                width: 300,
                                color: Colors.white,
                                child: Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      height: 100,
                                      width: 260,
                                      child: SelectableText(
                                        newText,
                                        textAlign: TextAlign.center,
                                      ),
                                      padding: EdgeInsets.all(10),
                                    ),
                                    Container(
                                        width: 30,
                                        height: 100,
                                        child: GestureDetector(
                                            onTap: () {
                                              Clipboard.setData(ClipboardData(
                                                      text: newText))
                                                  .then((value) => ScaffoldMessenger
                                                          .of(context)
                                                      .showSnackBar(SnackBar(
                                                          content: Text(
                                                              "Kopyaladım balım"))));
                                            },
                                            child: Container(
                                                width: 30,
                                                height: 30,
                                                child: Icon(Icons.copy))))
                                  ],
                                )));
                        placehold.notifyListeners();
                      },
              ),
              Container(
                height: 10,
              ),
              placehold.placehold
            ],
          )),
    );
  }
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    final imageProvider = context.watch<ImagesProvider>();
    final placehold = context.watch<placeholder>();

    final input = TextEditingController();
    final emoji = TextEditingController();

    late String newText;

    return Center(
      child: Container(
          width: 400,
          color: Color.fromARGB(255, 255, 235, 241),
          padding: EdgeInsets.only(top: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  imageProvider.imagesList[0],
                  imageProvider.imagesList[1],
                  imageProvider.imagesList[2],
                ],
                mainAxisAlignment: MainAxisAlignment.spaceAround,
              ),
              MainScope(),
              Row(
                children: [
                  imageProvider.imagesList[3],
                  imageProvider.imagesList[4],
                  imageProvider.imagesList[5],
                ],
                mainAxisAlignment: MainAxisAlignment.spaceAround,
              ),
            ],
          )),
    );
  }
}
