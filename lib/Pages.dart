import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Pages extends StatelessWidget {
  final int page;
  final Color color;

  const Pages({Key key, this.page, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: color,
      alignment: Alignment.center,
      child: Text(
        "Page " + page.toString(),
        style: TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
      ),
    );
  }
}
