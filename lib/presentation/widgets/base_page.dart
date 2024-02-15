import 'package:flutter/material.dart';

class BasePage extends StatelessWidget {
  final Widget child;
  final bool showAppBar; // Control AppBar visibility
  final PreferredSizeWidget? customAppBar; // Custom AppBar widget
  final List<Color> gradientColors;
  final AlignmentGeometry gradientBegin;
  final AlignmentGeometry gradientEnd;

  const BasePage({
    Key? key,
    required this.child,
    this.showAppBar = true, // Default to true for backward compatibility
    this.customAppBar, // Allow custom AppBar
    this.gradientColors = const [Colors.blue, Colors.pink],
    this.gradientBegin = Alignment.topRight,
    this.gradientEnd = Alignment.bottomLeft,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppBar
          ? customAppBar ??
              AppBar(
                // Default AppBar if customAppBar is not provided
                title: const Text('Default Title'),
                // Other AppBar properties as needed
              )
          : null, // Hide AppBar if showAppBar is false
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: gradientBegin,
            end: gradientEnd,
            colors: gradientColors,
          ),
        ),
        child: child,
      ),
    );
  }
}
