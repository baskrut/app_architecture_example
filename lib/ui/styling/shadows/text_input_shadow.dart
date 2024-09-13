import 'package:flutter/material.dart';

const textInputShadow = BoxShadow(
  color: Color.fromRGBO(0, 0, 0, 0.1),
  blurRadius: 20.0,
  spreadRadius: 0,
  offset: Offset(0.0, 2.0),
);

const textInputActiveShadow = BoxShadow(
  color: Color.fromRGBO(225, 244, 255, 1),
  blurRadius: 10.0,
  spreadRadius: 0,
  offset: Offset(0.0, 2.0),
);

const textInputErrorShadow = BoxShadow(
  color: Color.fromRGBO(254, 220, 220, 1),
  blurRadius: 10.0,
  spreadRadius: 0,
  offset: Offset(0.0, 2.0),
);
