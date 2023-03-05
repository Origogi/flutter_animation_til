import 'package:flutter/material.dart';

class AnimatedOpacityPage extends StatefulWidget {
  @override
  createState() => AnimatedOpacityPageState();
}

class AnimatedOpacityPageState extends State<AnimatedOpacityPage> {

bool _visible = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AnimatedOpacity'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedOpacity(
              opacity: _visible ? 1.0 : 0.0,
              duration: Duration(seconds: 1),
              curve: Curves.fastOutSlowIn,
              child: FlutterLogo(size: 200),
            ),
            ElevatedButton(
              child: Text('Fade Logo'),
              onPressed: () {
                setState(() {
                  _visible = false;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
