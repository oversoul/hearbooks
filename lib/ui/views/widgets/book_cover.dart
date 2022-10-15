import 'package:flutter/material.dart';
import 'package:hearbooks/plugins/animated_pos.dart';

class BookCover extends StatefulWidget {
  final Color color;
  final String image;
  const BookCover({
    super.key,
    required this.image,
    required this.color,
  });

  @override
  State<BookCover> createState() => _BookCoverState();
}

class _BookCoverState extends State<BookCover>
    with SingleTickerProviderStateMixin, RouteAware {
  double position = 0;
  double scale = 1;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: (details) {
        //
      },
      onHorizontalDragUpdate: (details) {
        final value = (100 - (details.localPosition.dx / 2)).clamp(0, 100);
        position = 2.0 / (100 / value);

        setState(() {});
      },
      onHorizontalDragEnd: (details) {
        if (position > 1.5) {
          position = 3.0;
          scale = 3.0;
          Future.delayed(const Duration(milliseconds: 200), () {
            Navigator.pushNamed(context, 'reader').then((value) {
              scale = 1;
              position = 0;
              setState(() {});
            });
          });
        } else {
          position = 0;
          scale = 1.0;
        }
        setState(() {});
      },
      child: AnimatedScale(
        duration: const Duration(milliseconds: 300),
        scale: scale,
        child: Container(
          width: 200,
          height: 300,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.3),
                blurRadius: 10,
              ),
            ],
          ),
          child: Stack(
            children: [
              SizedBox.expand(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 3),
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                  ),
                  child: AnimatedOpacity(
                    opacity: (3 - scale) / 2,
                    duration: const Duration(milliseconds: 400),
                    child: const Text(
                      "So she was considering in her own mind (as well as she could, for the hot day made her "
                      "feel very sleepy and stupid), whether the pleasure of making a daisy-chain would be "
                      "worth the trouble of getting up and picking the daisies, when suddenly a White "
                      "Rabbit with pink eyes ran close by her.\n",
                      style: TextStyle(fontSize: 12, height: 1.7),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
              ),
              AnimatedPos(
                duration: const Duration(milliseconds: 200),
                position: position,
                child: Container(
                  decoration: BoxDecoration(
                    color: widget.color,
                    image: DecorationImage(
                      image: AssetImage(widget.image),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
