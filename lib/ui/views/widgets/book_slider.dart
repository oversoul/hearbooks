import 'package:flutter/material.dart';
import 'package:hearbooks/core/models/book.dart';
import 'package:hearbooks/plugins/animated_gradient.dart';
import 'package:hearbooks/ui/views/widgets/book_cover.dart';

import 'book_slide.dart';
import 'bottom_navigation.dart';

class BookSlider extends StatefulWidget {
  const BookSlider({super.key});

  @override
  State<BookSlider> createState() => _BookSliderState();
}

class _BookSliderState extends State<BookSlider> {
  int current = 1;
  double opacity = 1;
  double currentPage = 1.0;
  late PageController pageController;

  @override
  void initState() {
    pageController = PageController(
      initialPage: current,
      viewportFraction: .7,
    );
    pageController.addListener(() => changeCurrentPage());
    super.initState();
  }

  changeCurrentPage() {
    setState(() {
      currentPage = pageController.page ?? currentPage;
    });
  }

  @override
  void dispose() {
    pageController.removeListener(() => changeCurrentPage());
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedGradient(
      duration: const Duration(milliseconds: 250),
      backgroundColor: books[current].color,
      child: Stack(
        children: [
          const Header(),
          const Align(
            alignment: Alignment.bottomCenter,
            child: BottomNavigation(),
          ),
          Align(
            alignment: Alignment.center,
            child: slider(),
          ),
        ],
      ),
    );
  }

  Widget showBookCover() {
    var offset = currentPage - currentPage.floor();
    return Opacity(
      opacity: offset > 0 ? 0 : 1,
      child: BookCover(
        image: books[current].image,
        color: books[current].color,
        navigate: () {
          //return Future.delayed(const Duration(seconds: 2), () {});
          return Navigator.pushNamed(context, 'reader');
        },
      ),
    );
  }

  Widget slider() {
    final height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).viewPadding.top -
        250;
    final width = MediaQuery.of(context).size.width;

    return SizedBox(
      height: height,
      child: Stack(
        children: [
          PageView.builder(
            itemCount: books.length,
            clipBehavior: Clip.none,
            controller: pageController,
            onPageChanged: (index) => setState(() => current = index),
            itemBuilder: (_, index) {
              return AnimatedBuilder(
                animation: pageController,
                child: BookSlide(books[index], active: current == index),
                builder: (BuildContext context, child) {
                  double offset = (index == current) ? 0 : 1;

                  if (pageController.position.hasContentDimensions) {
                    offset = (pageController.page ?? 0) - index;
                  }

                  double scale = Curves.easeOut.transform(
                    (1 - (offset.abs() * 0.4)).clamp(0.0, 1.0),
                  );
                  double boxHeight = scale * height;

                  return Align(
                    alignment: Alignment.center,
                    child: Transform.scale(
                      scale: scale,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(width / 2),
                          ),
                          color: Colors.white.withOpacity(
                            (1 - offset.abs()).clamp(0, 1.0),
                          ),
                        ),
                        child: SizedBox(height: boxHeight, child: child),
                      ),
                    ),
                  );
                },
              );
            },
          ),
          Align(alignment: Alignment.topCenter, child: showBookCover()),
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Listening Now",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          InkWell(
            child: Image.asset("assets/search.png", height: 32),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
