import 'package:flutter/material.dart';

class CommentCard extends StatefulWidget {
  final void Function() onCancel;
  final bool isComment;
  const CommentCard({
    super.key,
    this.isComment = false,
    required this.onCancel,
  });

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(40)),
      ),
      margin: const EdgeInsets.only(right: 20),
      padding: const EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
        bottom: 10,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text("Many more dark lines..."),
              CircleAvatar(backgroundColor: Colors.grey),
            ],
          ),
          Expanded(child: Container()),
          footer(),
        ],
      ),
    );
  }

  Widget footer() {
    if (widget.isComment) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: widget.onCancel,
            child: const Text("CANCEL", style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {},
            child: const Text("POST", style: TextStyle(color: Colors.black)),
          ),
        ],
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () {},
          child: Row(
            children: const [
              Icon(Icons.comment, size: 16),
              SizedBox(width: 5),
              Text("7"),
            ],
          ),
        ),
        TextButton(
          onPressed: () {},
          child: Row(
            children: const [
              Icon(Icons.favorite, size: 16),
              SizedBox(width: 5),
              Text("22"),
            ],
          ),
        ),
      ],
    );
  }
}
