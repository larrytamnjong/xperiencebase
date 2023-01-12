import 'package:flutter/material.dart';
import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:xperiencebase/constants/colors.dart';
import 'appbar.dart';

class LoadingScreen extends StatefulWidget {
  final String? waitingText;
  const LoadingScreen({Key? key, this.waitingText}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: 'Please wait...',
      ),
      body: SpinningLoaderWithBaseText(
        waitingText: widget.waitingText,
      ),
    );
  }
}

///Default loader
class SpinningLoaderWithBaseText extends StatelessWidget {
  final String? waitingText;
  const SpinningLoaderWithBaseText({
    Key? key,
    this.waitingText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 100.0),
          LoadingAnimationWidget.fourRotatingDots(
            color: kBlackColor,
            size: 50,
          ),
          const SizedBox(height: 11.0),
          Text(waitingText ?? ''),
        ],
      ),
    );
  }
}

///Use this Shimmer loader for the Application history page
class ApplicationsShimmerLoader extends StatelessWidget {
  const ApplicationsShimmerLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 3.0, right: 3.0),
      child: ListView.separated(
        itemBuilder: (_, i) {
          final delay = (i * 300);
          return Container(
            height: 130,
            decoration: BoxDecoration(
                color: kSurfaceVariant,
                borderRadius: BorderRadius.circular(10.0)),
            child: Padding(
              padding: const EdgeInsets.all(9.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RowWIthCircleShimmer(delay: delay),
                  const SizedBox(
                    height: 12,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FadeShimmer(
                          height: 10,
                          millisecondsDelay: delay,
                          width: 150,
                          radius: 4,
                          fadeTheme: FadeTheme.light,
                        ),
                        const SizedBox(
                          width: 25.0,
                        ),
                        FadeShimmer(
                          height: 20,
                          millisecondsDelay: delay,
                          width: 100,
                          radius: 10,
                          fadeTheme: FadeTheme.light,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: 10,
        separatorBuilder: (_, __) => const SizedBox(
          height: 16,
        ),
      ),
    );
  }
}

///Use this Shimmer loader for the For You page
class ForYouShimmerLoader extends StatelessWidget {
  const ForYouShimmerLoader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (_, i) {
        final delay = (i * 300);
        return Container(
          height: 200,
          decoration: BoxDecoration(
              color: kSurfaceVariant,
              borderRadius: BorderRadius.circular(10.0)),
          child: Padding(
            padding: const EdgeInsets.all(9.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RowWIthCircleShimmer(delay: delay),
                const SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: FadeShimmer(
                    height: 10,
                    millisecondsDelay: delay,
                    width: 200,
                    radius: 4,
                    fadeTheme: FadeTheme.light,
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: FadeShimmer(
                    height: 10,
                    millisecondsDelay: delay,
                    width: 200,
                    radius: 4,
                    fadeTheme: FadeTheme.light,
                  ),
                ),
                const SizedBox(
                  height: 32.0,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: FadeShimmer(
                      height: 40.0,
                      millisecondsDelay: delay,
                      width: 285,
                      radius: 10,
                      fadeTheme: FadeTheme.light,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      itemCount: 10,
      separatorBuilder: (_, __) => const SizedBox(
        height: 16,
      ),
    );
  }
}

///Row component for shimmer loader consisting of circle and two horizontal lines of varying length
class RowWIthCircleShimmer extends StatelessWidget {
  const RowWIthCircleShimmer({
    Key? key,
    required this.delay,
  }) : super(key: key);

  final int delay;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FadeShimmer.round(
          size: 50.0,
          fadeTheme: FadeTheme.light,
          millisecondsDelay: delay,
        ),
        const SizedBox(
          width: 8,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeShimmer(
              height: 15,
              width: 260,
              radius: 4,
              millisecondsDelay: delay,
              fadeTheme: FadeTheme.light,
            ),
            const SizedBox(
              height: 6,
            ),
            FadeShimmer(
              height: 8,
              millisecondsDelay: delay,
              width: 180,
              radius: 4,
              fadeTheme: FadeTheme.light,
            ),
          ],
        ),
      ],
    );
  }
}

///Loading Functions
bool isLoading = false;

startLoading() {
  isLoading = true;
}

stopLoading() {
  isLoading = false;
}
