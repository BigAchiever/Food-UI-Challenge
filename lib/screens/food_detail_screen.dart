import 'package:animated_transition_screen/widgets/animated_rows.dart';
import 'package:animated_transition_screen/widgets/button_tags.dart';
import 'package:flutter/material.dart';

import '../models/cetegory_model.dart';
import '../models/recent_items.dart';

// ignore: must_be_immutable
class DetailsScreen extends StatefulWidget {
  final int indexFromCardScreen;
  late bool istapped;

  DetailsScreen(
      {super.key, required this.indexFromCardScreen, required this.istapped});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  bool popped = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        setState(() {
          popped = true;
        });
        return true;
      },
      child: GestureDetector(
        onDoubleTap: () {
          Navigator.of(context).pop();
          setState(() {
            widget.istapped = false;
            popped = true;
          });
        },
        child: Scaffold(
          backgroundColor: const Color(0xff1d1d1d),
          body: Stack(children: [
            Positioned(
              top: -120,
              left: 0,
              right: 0,
              child: Hero(
                tag: 'food${widget.indexFromCardScreen}',
                child: Transform.rotate(
                  angle: -0.55,
                  child: Container(
                    width: 280,
                    height: 280,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/food1.png'),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                opacity: popped ? 0.0 : 1.0,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 200,
                      ),
                      const Text(
                        "CATEGORY",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      _categoryRow(),
                      const SizedBox(height: 40),
                      const Text(
                        "REECENT SEARCH",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 35),
                      _recentItems(),
                      const SizedBox(height: 40),
                      const Text(
                        "TAGS",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      ButtonColorChange(
                        isScreenPopped: popped,
                      )
                    ],
                  ),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }

  Widget _categoryRow() {
    return AnimatedRow(
      duration: 800,
      delay: 150 * 3,
      reverse: popped,
      children: sauceItems.map((item) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Image.asset(
                  item.imagePath,
                  width: 100,
                  height: 100,
                ),
                const SizedBox(height: 10),
                Text(
                  item.name,
                  style: const TextStyle(color: Colors.white, fontSize: 16.0),
                ),
                Text(
                  item.price,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 14.0),
                ),
              ],
            ),
          ],
        );
      }).toList(),
    );
  }

  Widget _recentItems() {
    return AnimatedRow(
      duration: 800,
      delay: 150 * 3,
      reverse: popped,
      children: drinkItems.map((item) {
        return Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.asset(
                item.imagePath,
                width: 120,
                height: 120,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              item.name,
              style: const TextStyle(color: Colors.white, fontSize: 14.0),
            ),
          ],
        );
      }).toList(),
    );
  }
}
