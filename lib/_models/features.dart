class Feature {
  const Feature({required this.t, required this.lt});
  final String t;
  final String lt;
}

class FeatureData {
  const FeatureData({required this.title, this.path = 'blog', required this.message});
  final String title;
  final String path;
  final String message;
}

class IntroFeature {
  const IntroFeature({required this.title, required this.description});
  final String title;
  final String description;
}
