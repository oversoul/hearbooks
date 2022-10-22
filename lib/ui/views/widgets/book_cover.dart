import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hearbooks/plugins/animated_roty.dart';

class BookCover extends StatefulWidget {
  final Color color;
  final String image;
  final Future<void> Function() navigate;

  const BookCover({
    super.key,
    required this.image,
    required this.color,
    required this.navigate,
  });

  @override
  State<BookCover> createState() => _BookCoverState();
}

class _BookCoverState extends State<BookCover> {
  double scale = 1;
  double position = 0;

  void navigate() {
    Future.delayed(const Duration(milliseconds: 400), () {
      widget.navigate().then((_) {
        setState(() {
          scale = 1;
          position = 0;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        final value = (100 - (details.localPosition.dx / 2)).clamp(0, 100);
        setState(() => position = 2.0 / (100 / value));
      },
      onHorizontalDragEnd: (details) {
        if (position > 1.5) {
          scale = 3.0;
          position = 3.0;
          navigate();
        } else {
          scale = 1.0;
          position = 0;
        }
        setState(() {});
      },
      child: AnimatedScale(
        scale: scale,
        alignment: const Alignment(0, -.5),
        duration: const Duration(milliseconds: 300),
        child: SizedBox(
          width: 220,
          height: 320,
          child: Stack(
            children: [
              SizedBox.expand(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 3, color: widget.color),
                    borderRadius: const BorderRadius.horizontal(
                      right: Radius.circular(6),
                    ),
                  ),
                  child: AnimatedOpacity(
                    opacity: (3 - scale) / 2,
                    duration: const Duration(milliseconds: 400),
                    child: buildContent(),
                  ),
                ),
              ),
              AnimatedRotY(
                duration: const Duration(milliseconds: 200),
                position: position,
                threshold: 1.6,
                backWidget: Container(color: widget.color),
                child: Container(
                  decoration: BoxDecoration(
                    color: widget.color,
                    image: DecorationImage(
                      image: AssetImage(widget.image),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: const BorderRadius.horizontal(
                      right: Radius.circular(6),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding buildContent() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: const Text(
          "So she was considering in her own mind (as well as she could, for the hot day made her feel very sleepy and stupid), whether the pleasure of making a daisy-chain would be worth the trouble of getting up and picking the daisies, when suddenly a White Rabbit with pink eyes ran close by her.\nworth the trouble of getting up and picking the daisies.",
          style: TextStyle(fontSize: 12, height: 1.6),
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }
}
