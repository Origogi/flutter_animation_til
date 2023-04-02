import 'package:flutter/widgets.dart';

class PageFlipBuilder extends StatefulWidget {
  const PageFlipBuilder(
      {Key? key, required this.frontBuilder, required this.backBuilder})
      : super(key: key);

  final WidgetBuilder frontBuilder;
  final WidgetBuilder backBuilder;

  @override
  PageFlipBuilderState createState() => PageFlipBuilderState();
}

class PageFlipBuilderState extends State<PageFlipBuilder> {
  void flip() {
    print('flip');
  }

  @override
  Widget build(BuildContext context) {
    return widget.frontBuilder(context);
  }
}
