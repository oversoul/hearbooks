import 'package:flutter/material.dart';
import 'package:hearbooks/core/models/book.dart';
import 'package:hearbooks/ui/shared/ui_helpers.dart';
import 'package:hearbooks/ui/views/widgets/book_cover.dart';

class BookSlide extends StatelessWidget {
  final Book book;

  const BookSlide(this.book, {super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular((width - 80) / 2),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(20),
            offset: const Offset(0, 20),
            spreadRadius: -8,
            blurRadius: 5,
          ),
        ],
      ),
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: 20,
            child: Column(
              children: [
                UIHelper.verticalSpaceSmall(),
                Text(
                  book.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                UIHelper.verticalSpaceSmall(),
                Text("Chapter 1 - ${book.time}"),
                UIHelper.verticalSpaceLarge(),
                InkWell(
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2),
                      borderRadius: const BorderRadius.all(Radius.circular(40)),
                    ),
                    child: const Icon(Icons.play_arrow, size: 30),
                  ),
                  onTap: () {},
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: BookCover(color: book.color, image: book.image),
          ),
        ],
      ),
    );
  }
}
