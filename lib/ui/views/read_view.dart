import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hearbooks/plugins/animated_roty.dart';
import 'package:hearbooks/ui/views/widgets/comments_list.dart';

class ReadView extends StatefulWidget {
  const ReadView({super.key});

  @override
  State<ReadView> createState() => _ReadViewState();
}

class _ReadViewState extends State<ReadView> {
  double position = 0;
  double opacity = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        opacity = 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, true);
        return false;
      },
      child: Material(
        color: Colors.transparent,
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.loose,
          children: [
            GestureDetector(
              onHorizontalDragUpdate: (d) {
                final value = (100 - (d.localPosition.dx / 2)).clamp(0, 100);
                position = -(.5 / (100 / value));
                setState(() {});
              },
              onHorizontalDragEnd: (details) {
                if (position < -.1) {
                  position = -.5;
                } else {
                  position = 0;
                }
                setState(() {});
              },
              child: AnimatedScale(
                scale: 1 - ((position * -2) * .1),
                duration: const Duration(milliseconds: 200),
                child: AnimatedRotY(
                  duration: const Duration(milliseconds: 200),
                  position: position,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular((position * -2) * 20),
                    ),
                    child: Scaffold(
                      appBar: header(),
                      backgroundColor: Colors.white,
                      body: AnimatedOpacity(
                        opacity: opacity,
                        duration: const Duration(milliseconds: 300),
                        child: content(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (position == -.5)
              Container(
                color: Colors.black54,
                height: double.infinity,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      right: 0,
                      height: 200,
                      top: height / 4,
                      child: CommentsList(
                        onClose: () {
                          setState(() {
                            position = 0;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget header() {
    return AppBar(
      title: const Text("Chapter I"),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () => Navigator.pop(context, true),
      ),
      actions: [
        IconButton(icon: const Icon(Icons.list), onPressed: () {}),
      ],
    );
  }

  Widget content() {
    return SingleChildScrollView(
      child: DefaultTextStyle.merge(
        style: const TextStyle(fontSize: 16.0, height: 1.8),
        textAlign: TextAlign.justify,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const <Widget>[
              Text(
                "Down the Rabbit-Hole",
                style: TextStyle(fontSize: 24.0),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32.0),
              Text(
                "Alice was beginning to get very tired of sitting by her sister on the bank, and of"
                " having nothing to do: once or twice she had peeped into the book her sister was "
                "reading, but it had no pictures or conversations in it, `and what is the use of "
                "a book,' thought Alice `without pictures or conversation?'\n\n"
                "So she was considering in her own mind (as well as she could, for the hot day made her "
                "feel very sleepy and stupid), whether the pleasure of making a daisy-chain would be "
                "worth the trouble of getting up and picking the daisies, when suddenly a White "
                "Rabbit with pink eyes ran close by her.\n\n"
                "There was nothing so very remarkable in that; nor did Alice think it so very much out "
                "of the way to hear the Rabbit say to itself, `Oh dear! Oh dear! I shall be "
                "late!' (when she thought it over afterwards, it occurred to her that she ought to "
                "have wondered at this, but at the time it all seemed quite natural); but when the "
                "Rabbit actually took a watch out of its waistcoat-pocket, and looked at it, and then "
                "hurried on, Alice started to her feet, for it flashed across her mind that she had "
                "never before seen a rabbit with either a waistcoat-pocket, or a watch to take out "
                "of it, and burning with curiosity, she ran across the field after it, and fortunately "
                "was just in time to see it pop down a large rabbit-hole under the hedge.",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
