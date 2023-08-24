import 'dart:async';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const FarsiWordGameApp(),
    );
  }
}

class FarsiWordGameApp extends StatelessWidget {
  const FarsiWordGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: FarsiWordGameScreen(),
    );
  }
}

class FarsiWordGameScreen extends StatelessWidget {
  const FarsiWordGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Farsi Word Game'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      decoration: const BoxDecoration(color: Colors.white),
                      child: Image.asset('assets/images/S-Main-1.png'),
                    ),
                    SizedBox(width: 2),
                    _buildDragTargetBox(context: context),
                  ],
                ),
                SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      decoration: const BoxDecoration(color: Colors.white),
                      child: Image.asset('assets/images/S-Main-4.png'),
                    ),
                    SizedBox(width: 2),
                    Container(
                      height: 80,
                      width: 80,
                      decoration: const BoxDecoration(color: Colors.white),
                      child: Image.asset('assets/images/S-main-3.png'),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            _buildWordList(),
          ],
        ),
      ),
    );
  }

  Widget _buildDragTargetBox({
    final context = BuildContext,
    // final Widget? child = null
  }) {
    return ImageTargetBox();
  }

  Widget _buildWordList() {
    // Image names
    List<String> images = [
      "assets/images/S-Main-1.png",
      "assets/images/S-Main-2.png", // the correct one
      "assets/images/S-Main-4.png",
    ];

    return Column(
      children: images.map((image) {
        return ListTile(
          trailing: Draggable<String>(
            data: image,
            feedback: Material(
              child: Container(
                child: Image.asset(image),
              ),
            ),
            childWhenDragging: Container(),
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 3),
              child: Image.asset(image),
            ),
          ),
        );
      }).toList(),
    );
  }
}

@immutable
class ImageTargetBox extends StatefulWidget {
  const ImageTargetBox({super.key});

  @override
  State<ImageTargetBox> createState() => _ImageTargetBoxState();
}

class _ImageTargetBoxState extends State<ImageTargetBox> {
  late Widget child;

  @override
  void initState() {
    child = DottedBorder(
      color: Colors.red.shade300,
      child: const SizedBox(width: 80, height: 80),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DragTarget<String>(
      builder: (context, candidateData, rejectedData) {
        return child;
      },
      onAccept: (data) {
        if (data == 'assets/images/S-Main-2.png') {
          child =
              Image.asset('assets/images/S-Main-2.png', width: 80, height: 80);

          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("You got it :-))))"),
          ));
        } else {

          Timer(Duration(seconds: 2), () {
            setState(() {
              child = Container(width: 80, height: 80, color: Colors.red);
            });
          });

          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Try again :-))))"),
          ));
        }
      },
    );
  }
}
