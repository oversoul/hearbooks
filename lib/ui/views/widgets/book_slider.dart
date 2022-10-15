import 'package:hearbooks/core/models/book.dart';
import 'package:hearbooks/plugins/animated_box.dart';

import 'package:flutter/material.dart';

import 'book_slide.dart';
import 'bottom_navigation.dart';

class BookSlider extends StatefulWidget {
  const BookSlider({super.key});

  @override
  State<BookSlider> createState() => _BookSliderState();
}

class _BookSliderState extends State<BookSlider> {
  late Color _fabColor;

  @override
  void initState() {
    _fabColor = books[1].color;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).viewPadding.top;

    return AnimatedBox(
      duration: const Duration(milliseconds: 250),
      backgroundColor: _fabColor,
      child: Column(
        children: [
          Container(
            height: 80,
            padding: const EdgeInsets.symmetric(horizontal: 20),
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
          ),
          SizedBox(
            height: height - 200,
            child: PageView.builder(
              clipBehavior: Clip.none,
              controller: PageController(
                viewportFraction: .8,
                initialPage: 1,
              ),
              onPageChanged: (index) {
                _fabColor = books[index].color;
                setState(() {});
              },
              itemBuilder: (_, index) => BookSlide(books[index]),
              itemCount: books.length,
            ),
          ),
          const Spacer(),
          BottomNavigation(_fabColor),
        ],
      ),
    );
  }
}
