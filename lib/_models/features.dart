import 'package:flutter/material.dart';

class Feature {
  const Feature({required this.t});
  final String t;
}

class FeatureData {
  const FeatureData({this.title = '', this.path = '', this.message = ''});
  final String title;
  final String path;
  final String message;
}

class IntroFeature {
  const IntroFeature({required this.title, required this.description, required this.icon});
  final String title;
  final String description;
  final IconData icon;
}
