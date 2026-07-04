import 'package:flutter/material.dart';

class CustomSafeArea extends StatelessWidget {
  final Widget child;
  final List<String> edges;

  const CustomSafeArea({
    super.key,
    required this.child,
    this.edges = const ['top', 'bottom', 'left', 'right'],
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: edges.contains('top'),
      bottom: edges.contains('bottom'),
      left: edges.contains('left'),
      right: edges.contains('right'),
      child: child,
    );
  }
}
