import 'package:flutter/material.dart';

import '../rendering/sliver_masonry_grid.dart';
import '../rendering/sliver_simple_grid_delegate.dart';

class SliverMasonryGrid extends SliverMultiBoxAdaptorWidget {
  /// Creates a sliver that places its children in a Masonry arrangement.
  ///
  /// The [mainAxisSpacing] and [crossAxisSpacing] arguments must be greater
  /// than zero.
  const SliverMasonryGrid({
    super.key,
    required super.delegate,
    required this.gridDelegate,
    this.mainAxisSpacing = 0,
    this.crossAxisSpacing = 0,
  });

  final SliverSimpleGridDelegate gridDelegate;
  final double mainAxisSpacing;
  final double crossAxisSpacing;

  @override
  RenderSliverMasonryGrid createRenderObject(BuildContext context) {
    final SliverMultiBoxAdaptorElement element = context as SliverMultiBoxAdaptorElement;

    return RenderSliverMasonryGrid(
      childManager: element,
      gridDelegate: gridDelegate,
      mainAxisSpacing: mainAxisSpacing,
      crossAxisSpacing: crossAxisSpacing,
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderSliverMasonryGrid renderObject) {
    renderObject
      ..gridDelegate = gridDelegate
      ..mainAxisSpacing = mainAxisSpacing
      ..crossAxisSpacing = crossAxisSpacing;
  }
}
