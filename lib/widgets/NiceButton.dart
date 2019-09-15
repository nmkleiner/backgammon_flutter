import 'package:flutter/material.dart';

class NiceButton extends StatelessWidget {
  final Function onPressed;
  final String text;

  NiceButton({this.onPressed, this.text});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressed,
      child: Text(text),
      color: Colors.red,
      textColor: Colors.white,
      padding: const EdgeInsets.all(15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: Colors.transparent,
          style: BorderStyle.solid,
        ),
      ),
    );
  }
}
