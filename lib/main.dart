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
  }) {
    return DragTarget<String>(
      builder: (context, candidateData, rejectedData) {
        return Container(
          width: 80,
          height: 80,
          child: Center(child: Text('Drop here')),
        );
      },
      onAccept: (data) {
        if (data == 'assets/images/S-Main-2.png') {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("You got it :-))))"),
          ));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Try again :-))))"),
          ));
        }
      },
    );
  }

  Widget _buildWordList() {
    // Image names
    List<String> images = [
      "assets/images/S-Main-1.png",
      "assets/images/S-Main-2.png", // the correct one
      "assets/images/S-Main-4.png"
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
