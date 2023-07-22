import 'package:flutter/material.dart';

import '../screens/food_detail_screen.dart';
import 'pricetag.dart';

class CarouselCard extends StatefulWidget {
  final IconData icon;
  final String name;
  final String date;
  final int index;
  final Color color;
  final String recipeName;
  final String nutrient;
  final bool isExpanded;
  final PageController carouselController;

  const CarouselCard({
    Key? key,
    required this.icon,
    required this.name,
    required this.index,
    required this.color,
    required this.isExpanded,
    required this.carouselController,
    required this.date,
    required this.recipeName,
    required this.nutrient,
  }) : super(key: key);

  @override
  State<CarouselCard> createState() => _CarouselCardState();
}

class _CarouselCardState extends State<CarouselCard>
    with TickerProviderStateMixin {
  bool tapped = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          tapped = true;
        });
        Navigator.of(context).push(
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 800),
            reverseTransitionDuration: const Duration(milliseconds: 800),
            pageBuilder: (context, animation, secondaryAnimation) {
              return FadeTransition(
                opacity: Tween<double>(
                  begin: 0.8, // Set the initial opacity value (custom range)
                  end: 1.0, // Set the final opacity value (custom range)
                ).animate(animation),
                child: DetailsScreen(
                  istapped: tapped,
                  indexFromCardScreen: widget.index,
                ),
              );
            },
          ),
        );
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: MediaQuery.sizeOf(context).height / 1.5,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              color: widget.color,
            ),
            child: Stack(children: [
              Positioned(
                left: -20,
                top: 550 / 2.4,
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.4),
                      width: 8,
                    ),
                  ),
                ),
              ),
              Positioned(
                right: -100,
                bottom: -50,
                child: Container(
                  width: 380,
                  height: 380,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      opacity: 0.13,
                      image: AssetImage('assets/food1.png'),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: -20,
                bottom: -30,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.4),
                      width: 8,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 24,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 24,
                          backgroundColor: Colors.cyan,
                          backgroundImage: AssetImage('assets/profile.jpg'),
                        ),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              widget.date,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                letterSpacing: 1.2,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Divider(
                      color: Colors.white.withOpacity(0.8),
                      thickness: 1,
                      endIndent: 80,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.recipeName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 34,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              widget.nutrient,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        const Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Icon(
                            Icons.favorite,
                            color: Colors.black,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 20,
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        shadowColor: Colors.black.withOpacity(0.6),
                      ),
                      onPressed: () {},
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 14),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircleAvatar(
                                radius: 8,
                                backgroundColor: Colors.black,
                                child: Icon(
                                  Icons.add,
                                  size: 16,
                                )),
                            SizedBox(width: 12),
                            Text(
                              'Add to bag',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    AnimatedSize(
                      alignment: Alignment.center,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      child: Visibility(
                        visible: widget.carouselController.page == widget.index,
                        child: SizedBox(
                          height: 32,
                          width: widget.isExpanded ? 90 : 0,
                          child: CustomPaint(
                            painter: PriceTagPaint(),
                            child: const Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Center(
                                child: Text(
                                  "\$42.32",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20)
                  ],
                ),
              ),
            ]),
          ),
          Positioned(
            right: -25,
            bottom: 0,
            child: AnimatedBuilder(
              animation: widget.carouselController,
              builder: (_, __) {
                final double page = widget.carouselController.page ?? 0;
                final double rotation = (page - widget.index) *
                    -1.0; // Adjust the rotation speed here

                return Transform.rotate(
                  angle: rotation,
                  child: Hero(
                    tag: "food${widget.index}",
                    child: Container(
                      width: 300,
                      height: 300,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/food1.png'),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
