import 'package:flutter/widgets.dart';

class PageFlipBuilder extends StatefulWidget {
  const PageFlipBuilder(
      {Key? key, required this.frontBuilder, required this.backBuilder})
      : super(key: key);

  final WidgetBuilder frontBuilder;
  final WidgetBuilder backBuilder;

  @override
  State<PageFlipBuilder> createState() => _PageFlipBuilderState();
}

class _PageFlipBuilderState extends State<PageFlipBuilder> {
  @override
  Widget build(BuildContext context) {
    return widget.frontBuilder(context);
  }
}
