import 'package:flutter/material.dart';

class Dot extends StatelessWidget {
  final bool isVisible;
  
  Dot(this.isVisible);

  double get _getOpacity {
    return isVisible ? 1.0 : 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: _getOpacity,
      child: Container(
        width: 6,
        height: 6,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.black,
        ),
      ),
    );
  }
}
