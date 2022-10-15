import 'package:flutter/material.dart';

class Book {
  final String image;
  final Color color;
  final String name;
  final String time;

  const Book({
    required this.image,
    required this.color,
    required this.name,
    required this.time,
  });
}

const books = [
  Book(
    name: "Where I End and You Begin",
    color: Color(0xFF00d1c3),
    image: "assets/book1.jpg",
    time: '12:44',
  ),
  Book(
    name: "The Bees",
    color: Color(0xffFFC571),
    image: "assets/book2.jpg",
    time: '12:44',
  ),
  Book(
    name: "Origin",
    color: Color(0xFFDA5C72),
    image: "assets/book3.jpg",
    time: '14:32',
  ),
];
