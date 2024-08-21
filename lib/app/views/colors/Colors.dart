import 'package:flutter/material.dart';
const MaterialColor primary = MaterialColor(_primaryPrimaryValue, <int, Color>{
  40: Color(0x077604),
  50: Color(0xFFE0F7EC),
  100: Color(0xFFB3ECD0),
  200: Color(0xFF80DFB1),
  300: Color(0xFF4DD292),
  400: Color(0xFF26C97A),
  500: Color(_primaryPrimaryValue),
  600: Color(0xFF00B95B),
  700: Color(0xFF00B151),
  800: Color(0xFF00A947),
  900: Color(0xFF009B35),
});
const int _primaryPrimaryValue = 0xFF00BF63;

const MaterialColor primaryAccent = MaterialColor(_primaryAccentValue, <int, Color>{
  100: Color(0xFFC6FFD5),
  200: Color(_primaryAccentValue),
  400: Color(0xFF60FF8A),
  700: Color(0xFF47FF78),
});
const int _primaryAccentValue = 0xFF93FFB0;

const MaterialColor secondary = MaterialColor(_secondaryPrimaryValue, <int, Color>{
  50: Color(0xFFE7E7E8),
  100: Color(0xFFC2C2C6),
  200: Color(0xFF9A99A0),
  300: Color(0xFF71707A),
  400: Color(0xFF52525E),
  500: Color(_secondaryPrimaryValue),
  600: Color(0xFF2F2E3B),
  700: Color(0xFF272732),
  800: Color(0xFF21202A),
  900: Color(0xFF15141C),
});
const int _secondaryPrimaryValue = 0xFF343341;

const MaterialColor secondaryAccent = MaterialColor(_secondaryAccentValue, <int, Color>{
  100: Color(0xFF6363FF),
  200: Color(_secondaryAccentValue),
  400: Color(0xFF0000FC),
  700: Color(0xFF0000E2),
});
const int _secondaryAccentValue = 0xFF3030FF;