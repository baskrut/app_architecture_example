import 'package:flutter/material.dart';

class ElevatedWhiteBox extends StatelessWidget {
  final Widget child;
  final bool hasPadding;

  const ElevatedWhiteBox({required this.child, this.hasPadding = true, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: hasPadding ? const EdgeInsets.all(20.0) : EdgeInsets.zero,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40.0),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.2),
            blurRadius: 37.0,
            spreadRadius: 0,
            offset: Offset(0.0, 4.0),
          )
        ],
      ),
      child: child,
    );
  }
}
