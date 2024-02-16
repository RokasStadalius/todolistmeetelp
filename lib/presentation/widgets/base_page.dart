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
    this.gradientColors = const [Color(0xfffff700), Color(0xff3cd515)],
    this.gradientBegin = Alignment.topLeft,
    this.gradientEnd = Alignment.bottomRight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: showAppBar
          ? customAppBar ??
              AppBar(
                elevation: 0,
                title: const Text('Default Title'),
              )
          : null,
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
