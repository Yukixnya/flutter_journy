import 'package:flutter/material.dart';

class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext,BoxConstraints) builder;
  const ResponsiveBuilder({required this.builder, super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder( builder: builder);
  }
}