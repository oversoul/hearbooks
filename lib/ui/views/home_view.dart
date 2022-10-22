import 'package:flutter/material.dart';
import 'package:hearbooks/ui/views/widgets/book_slider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: BookSlider()),
    );
  }
}
