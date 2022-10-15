import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  final Color color;
  const BottomNavigation(this.color, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.all(10),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withOpacity(.1),
              Colors.transparent,
              Colors.white.withOpacity(.08),
            ],
            stops: const [0, .4, .7],
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            bottomButton(Icons.book, true),
            const SizedBox(width: 10),
            bottomButton(Icons.bubble_chart),
            const SizedBox(width: 10),
            bottomButton(Icons.person),
          ],
        ),
      ),
    );
  }

  Widget bottomButton(IconData icon, [bool current = false]) {
    return Expanded(
      child: InkWell(
        child: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            color: current ? Colors.white : Colors.transparent,
            borderRadius: const BorderRadius.all(
              Radius.circular(30),
            ),
          ),
          child: Icon(
            icon,
            color: current ? Colors.black : Colors.black.withOpacity(.4),
          ),
        ),
        onTap: () {},
      ),
    );
  }
}
