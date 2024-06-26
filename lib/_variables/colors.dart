import 'package:flutter/material.dart';

class ColorObject {
  const ColorObject(
      {required this.color, required this.shadeColor, required this.textColor, this.isThemeAccent = false});
  final Color color;
  final Color shadeColor;
  final Color textColor;
  final bool isThemeAccent;
}

Map<String, ColorObject> backgroundColors = {
  'x': ColorObject(color: Colors.transparent, shadeColor: Colors.transparent, textColor: Colors.grey),
  '0': ColorObject(color: Colors.red, shadeColor: Colors.red.shade200, textColor: Colors.white, isThemeAccent: true),
  '1':
      ColorObject(color: Colors.green, shadeColor: Colors.green.shade200, textColor: Colors.white, isThemeAccent: true),
  '2': ColorObject(color: Colors.blue, shadeColor: Colors.blue.shade200, textColor: Colors.white, isThemeAccent: true),
  '3': ColorObject(color: Colors.orange, shadeColor: Colors.orange.shade200, textColor: Colors.black),
  '4': ColorObject(color: Colors.pink, shadeColor: Colors.pink.shade200, textColor: Colors.white, isThemeAccent: true),
  '5': ColorObject(color: Colors.yellow, shadeColor: Colors.yellow.shade200, textColor: Colors.black87),
  '6': ColorObject(
      color: Colors.purple, shadeColor: Colors.purple.shade200, textColor: Colors.white, isThemeAccent: true),
  '7':
      ColorObject(color: Colors.brown, shadeColor: Colors.brown.shade200, textColor: Colors.white, isThemeAccent: true),
  '8': ColorObject(color: Colors.amber, shadeColor: Colors.amber.shade200, textColor: Colors.black),
  '9': ColorObject(color: Colors.teal, shadeColor: Colors.teal.shade200, textColor: Colors.white),
  '10': ColorObject(color: Colors.lime, shadeColor: Colors.lime.shade200, textColor: Colors.black),
  '11': ColorObject(color: Colors.cyan, shadeColor: Colors.cyan.shade200, textColor: Colors.black),
  '12': ColorObject(
      color: Colors.deepOrange, shadeColor: Colors.deepOrange.shade200, textColor: Colors.white, isThemeAccent: true),
  '13': ColorObject(color: Colors.lightGreen, shadeColor: Colors.lightGreen.shade200, textColor: Colors.black),
  '14': ColorObject(color: Colors.lightBlue, shadeColor: Colors.lightBlue.shade200, textColor: Colors.black),
  '15': ColorObject(color: Colors.indigo, shadeColor: Colors.indigo.shade200, textColor: Colors.white),
  '16': ColorObject(color: Colors.deepPurple, shadeColor: Colors.deepPurple.shade200, textColor: Colors.white),
  '17': ColorObject(color: Colors.cyan, shadeColor: Colors.cyan.shade200, textColor: Colors.black),
  '18': ColorObject(color: Colors.grey, shadeColor: Colors.grey.shade200, textColor: Colors.black),
  '19': ColorObject(color: Colors.blueGrey, shadeColor: Colors.blueGrey.shade200, textColor: Colors.black),
};
