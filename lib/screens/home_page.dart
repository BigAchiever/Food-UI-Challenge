import 'dart:math';

import 'package:animated_transition_screen/models/name_model.dart';
import 'package:animated_transition_screen/models/recipe_n_nutrient.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/carousel_cubit.dart';
import '../theme.dart';
import '../widgets/card.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  final _carouselController = PageController(viewportFraction: 0.8);
  late AnimationController _animationController;
  bool _isPriceTagExpanded = true; //initially set to true

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _isPriceTagExpanded = true;
        });
      }
    });
    final carouselCubit = context.read<CarouselCubit>();
    _carouselController.addListener(() {
      final page = _carouselController.page?.round();
      if (page == null) return;
      if (carouselCubit.state.selectedCardIndex != page) {
        carouselCubit.selectCard(page);

        setState(() {
          _isPriceTagExpanded = false;
          _animationController.forward(from: 0.0);
        });
      }
    });
  }

  @override
  void dispose() {
    _carouselController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xff1d1d1d),
          elevation: 0,
          title: const Text(
            "DISCOVER",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          leading: Container(
              margin: const EdgeInsets.all(8),
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  image: const DecorationImage(
                      image: AssetImage("assets/profile.jpg"),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.blue)),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.search,
                size: 30,
              ),
              onPressed: () {},
            ),
          ]),
      backgroundColor: const Color(0xff1d1d1d),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.only(left: 12.0),
                  child: Column(
                    children: [
                      Text("F   E   A   T   .",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 34,
                              fontWeight: FontWeight.bold)),
                      SizedBox(height: 13),
                      Text(".  U   R   E   D",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 34,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: ExpandablePageView.builder(
                    onPageChanged: (value) {
                      setState(() {
                        _isPriceTagExpanded = false;
                        _animationController.forward(from: 0.0);
                      });
                    },
                    padEnds: false,
                    controller: _carouselController,
                    clipBehavior: Clip.none,
                    itemCount: 100,
                    itemBuilder: (_, index) {
                      if (!_carouselController.position.haveDimensions) {
                        return const SizedBox();
                      }

                      final int normalizedIndex =
                          index % 100; // Normalize the index
                      final Color color =
                          AppTheme.getCardColor(index); // Get the card color
                      final items = profileItems.map((item) {
                        return ProfileName(name: item.name, date: item.date);
                      }).toList();

                      final recipeAndNurtients = recipeItems.map((item) {
                        return RecipeNNutrients(
                            recipeNames: item.recipeNames,
                            nutrientQuantity: item.nutrientQuantity);
                      }).toList();

                      return AnimatedBuilder(
                        animation: _carouselController,
                        builder: (_, __) => Transform.scale(
                          origin: Offset.fromDirection(0.0, 50.0),
                          alignment: Alignment.topLeft,
                          scale: max(
                            0.6,
                            (1 - (_carouselController.page! - index).abs() / 2),
                          ),
                          child: CarouselCard(
                            isExpanded: _isPriceTagExpanded,
                            icon: Icons.bolt_outlined,
                            name: items[normalizedIndex].name,
                            date: items[normalizedIndex].date,
                            index: normalizedIndex,
                            color: color,
                            carouselController: _carouselController,
                            nutrient: recipeAndNurtients[normalizedIndex]
                                .nutrientQuantity,
                            recipeName:
                                recipeAndNurtients[normalizedIndex].recipeNames,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 60),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
