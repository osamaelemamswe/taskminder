import 'dart:ui';

import 'package:flutter/material.dart';

const primaryColor = Color(0xff00ef00);

Map<int, Color> primaryMaterialColorSwatch =
{
  50: const Color.fromRGBO(0, 239, 0, .1),
  100: const Color.fromRGBO(0, 239, 0, .2),
  200: const Color.fromRGBO(0, 239, 0, .3),
  300: const Color.fromRGBO(0, 239, 0, .4),
  400: const Color.fromRGBO(0, 239, 0, .5),
  500: const Color.fromRGBO(0, 239, 0, .6),
  600: const Color.fromRGBO(0, 239, 0, .7),
  700: const Color.fromRGBO(0, 239, 0, .8),
  800: const Color.fromRGBO(0, 239, 0, .9),
  900: const Color.fromRGBO(0, 239, 0, 1),
};

MaterialColor primaryMaterialColor = MaterialColor(0xFF00ef00, primaryMaterialColorSwatch);