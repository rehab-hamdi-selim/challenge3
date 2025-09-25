import 'package:flutter/material.dart';

class DotsLoading extends StatefulWidget {
  const DotsLoading({
    super.key,
    this.dotColor = Colors.white,
    this.dotSize = 10.0,
    this.spacing = 8.0,
    this.duration = const Duration(milliseconds: 1200),
    this.curve = Curves.easeInOut,
    this.minScale = 0.6,
    this.minOpacity = 0.3,
  });

  final Color dotColor;
  final double dotSize;
  final double spacing;
  final Duration duration;
  final Curve curve;
  final double minScale;
  final double minOpacity;

  @override
  State<DotsLoading> createState() => _DotsLoadingState();
}

class _DotsLoadingState extends State<DotsLoading>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final List<Animation<double>> _opacities;
  late final List<Animation<double>> _scales;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();
    _opacities = List.generate(3, (i) {
      final curved = CurvedAnimation(
        parent: _controller,
        curve: Interval(0.2 * i, 0.2 * i + 0.6, curve: widget.curve),
      );
      return Tween<double>(begin: widget.minOpacity, end: 1.0).animate(curved);
    });

    _scales = List.generate(3, (i) {
      final curved = CurvedAnimation(
        parent: _controller,
        curve: Interval(0.2 * i, 0.2 * i + 0.6, curve: widget.curve),
      );
      return Tween<double>(begin: widget.minScale, end: 1.0).animate(curved);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _dot(int i) {
    final fixedBox = SizedBox(
      width: widget.dotSize,
      height: widget.dotSize,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: widget.dotColor,
          shape: BoxShape.circle,
        ),
      ),
    );

    return FadeTransition(
      opacity: _opacities[i],
      child: ScaleTransition(scale: _scales[i], child: fixedBox),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _dot(0),
        SizedBox(width: widget.spacing),
        _dot(1),
        SizedBox(width: widget.spacing),
        _dot(2),
      ],
    );
  }
}
