import 'package:flutter/material.dart';
import 'package:hearbooks/core/models/book.dart';
import 'package:hearbooks/ui/shared/ui_helpers.dart';
import 'package:hearbooks/ui/views/widgets/painters/player_progress.dart';

class BookSlide extends StatelessWidget {
  final Book book;
  final bool active;

  const BookSlide(this.book, {super.key, required this.active});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            UIHelper.verticalSpaceSmall(),
            Text(
              book.name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            UIHelper.verticalSpaceMedium(),
            Text("Chapter 1 - ${book.time}"),
            UIHelper.verticalSpaceMedium(),
            InkWell(
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: const BorderRadius.all(Radius.circular(40)),
                ),
                child: const Icon(Icons.play_arrow, size: 30),
              ),
              onTap: () {},
            ),
            UIHelper.verticalSpaceLarge(),
          ],
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            width: 220,
            height: 320,
            decoration: BoxDecoration(
              color: book.color,
              image: DecorationImage(
                image: AssetImage(book.image),
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(15, 20),
                  color: Colors.black.withOpacity(.2),
                  blurRadius: 15,
                ),
              ],
              borderRadius: const BorderRadius.horizontal(
                right: Radius.circular(6),
              ),
            ),
          ),
        ),
        Opacity(
          opacity: active ? 1 : 0,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: TweenAnimationBuilder(
              duration: const Duration(milliseconds: 500),
              tween: Tween<double>(begin: 0, end: active ? 0.5 : 0),
              builder: (_, value, child) {
                return CustomPaint(
                  size: const Size(double.infinity, 120),
                  painter: PlayerProgress(
                    margin: 15,
                    progress: value,
                    inactiveColor: Colors.grey.shade500,
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
