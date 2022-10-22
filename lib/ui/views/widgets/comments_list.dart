import 'package:flutter/material.dart';
import 'comment_card.dart';

class CommentsList extends StatefulWidget {
  final void Function() onClose;
  const CommentsList({super.key, required this.onClose});

  @override
  State<CommentsList> createState() => _CommentsListState();
}

class _CommentsListState extends State<CommentsList> {
  double initialY = 0;
  late ScrollController _controller;

  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  List<int> items = [];
  int counter = 0;

  @override
  void initState() {
    _controller = ScrollController();
    super.initState();
    loadItems();
  }

  void loadItems() async {
    for (int item in [1, 2, 3]) {
      await Future.delayed(const Duration(milliseconds: 100));
      items.add(item);
      listKey.currentState?.insertItem(items.length - 1);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width - 80;

    return Listener(
      onPointerDown: (event) {
        setState(() {
          initialY = event.position.dx;
        });
      },
      onPointerUp: (opm) {
        if (_controller.offset > 0.0) return;
        if (opm.position.dx - initialY > 100) {
          widget.onClose();
        }
      },
      child: AnimatedList(
        key: listKey,
        controller: _controller,
        initialItemCount: items.length,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, int index, animation) {
          return SlideTransition(
            position: animation.drive(
              Tween(
                begin: const Offset(1.2, 0),
                end: const Offset(0, 0),
              ).chain(CurveTween(curve: const ElasticOutCurve(1.2))),
            ),
            child: SizedBox(
              width: width,
              child: CommentCard(
                onCancel: widget.onClose,
                isComment: index == 0,
              ),
            ),
          );
        },
        padding: const EdgeInsets.only(left: 20),
      ),
    );
  }
}
