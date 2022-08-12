import 'package:bmi_app/providers/clock_provider.dart';
import 'package:bmi_app/widgets/mini/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewUsScreen extends StatefulWidget {
  const ReviewUsScreen({
    Key? key,
    required this.title,
    this.paddingTop,
  }) : super(key: key);

  final String title;

  final double? paddingTop;

  @override
  State<ReviewUsScreen> createState() => _ReviewUsScreenState();
}

class _ReviewUsScreenState extends State<ReviewUsScreen> {
  double? ratings;

  @override
  void dispose() {
    ClockProvider().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // var args = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      floatingActionButton: ratings != null && ratings != 0
          ? FloatingActionButton(
              onPressed: () {},
              elevation: 15,
              child: const Icon(
                Icons.send,
                color: Colors.white,
              ))
          : Container(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: widget.paddingTop),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TitleWidget(
                  title: widget.title,
                ),
              ),
              Expanded(
                child: SizedBox(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Spacer(),
                        Column(
                          children: [
                            const Text(
                              'Give your experience!',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            const SizedBox(height: 30),
                            RatingBar.builder(
                              itemSize: 50,
                              initialRating: 0,
                              itemCount: 5,
                              itemBuilder: (context, index) {
                                switch (index) {
                                  case 0:
                                    return const Icon(
                                      Icons.sentiment_very_dissatisfied,
                                      color: Colors.red,
                                    );
                                  case 1:
                                    return const Icon(
                                      Icons.sentiment_dissatisfied,
                                      color: Colors.redAccent,
                                    );
                                  case 2:
                                    return const Icon(
                                      Icons.sentiment_neutral,
                                      color: Colors.amber,
                                    );
                                  case 3:
                                    return const Icon(
                                      Icons.sentiment_satisfied,
                                      color: Colors.lightGreen,
                                    );
                                  default:
                                    return const Icon(
                                      Icons.sentiment_very_satisfied,
                                      color: Colors.green,
                                    );
                                }
                              },
                              onRatingUpdate: (rating) {
                                setState(() {
                                  ratings = rating;
                                });
                              },
                            ),
                          ],
                        ),
                        const Spacer(
                          flex: 2,
                        ),
                      ],
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
}
