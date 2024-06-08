import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  final Color? color;
  final double strokeWidth;

  const Loader({
    super.key,
    this.color,
    this.strokeWidth = 3,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        strokeWidth: strokeWidth,
        color: color ?? Theme.of(context).colorScheme.onSurface,
      ),
    );
  }
}
