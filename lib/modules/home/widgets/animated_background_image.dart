import 'package:allia_health/models/time_of_day_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';

class AnimatedBackgroundImage extends StatefulWidget {
  const AnimatedBackgroundImage({
    super.key,
    required this.current,
    this.children = const [],
  });

  final TimeOfDayData current;
  final List<Widget> children;

  @override
  State<AnimatedBackgroundImage> createState() =>
      _AnimatedBackgroundImageState();
}

class _AnimatedBackgroundImageState extends State<AnimatedBackgroundImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animationTopCloud;
  late Animation<double> _animationCenterCloud;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();

    _animationTopCloud =
        Tween<double>(begin: -220, end: 600).animate(_controller);
    _animationCenterCloud =
        Tween<double>(begin: -220, end: 600).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topLeft,
      clipBehavior: Clip.none,
      children: [
        Image.asset('assets/images/${widget.current.backgroundImage}'),
        if (widget.current.index != 2)
          AnimatedBuilder(
            animation: _animationTopCloud,
            builder: (context, child) {
              return Positioned(
                top: 0,
                left: _animationTopCloud.value,
                child: Image.asset(
                  'assets/images/cloud1.png',
                  width: 180,
                ),
              );
            },
          ),
        if (widget.current.index != 2)
          AnimatedBuilder(
            animation: _animationCenterCloud,
            builder: (context, child) {
              return Positioned(
                top: 250,
                left: _animationCenterCloud.value,
                child: Image.asset(
                  'assets/images/cloud2.png',
                  width: 200,
                ),
              );
            },
          ),
        if (widget.current.index == 2)
          Transform.rotate(
            angle: 90 * 3.1415926535 / 180,
            child: Opacity(
              opacity: .5,
              child: Lottie.asset(
                'assets/lottie/stars.json',
                height: MediaQuery.sizeOf(context).height / 2,
                width: MediaQuery.sizeOf(context).width,
              ),
            ),
          ),
        ...widget.children,
      ],
    );
  }
}
