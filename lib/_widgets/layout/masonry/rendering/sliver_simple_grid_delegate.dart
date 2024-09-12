// ignore_for_file: comment_references

import 'package:flutter/rendering.dart';

/// Controls the layout of tiles in a some slivers.
///
/// See also:
///
///  * [SliverSimpleGridDelegateWithFixedCrossAxisCount], which creates a
///    layout with a fixed number of tiles in the cross axis.
///  * [SliverSimpleGridDelegateWithMaxCrossAxisExtent], which creates a layout
///    with tiles that have a maximum cross-axis extent.
///  * [RenderSliverMasonryGrid], which uses this delegate to control the layout
///  of its tiles.
abstract class SliverSimpleGridDelegate {
  /// Abstract const constructor. This constructor enables subclasses to provide
  /// const constructors so that they can be used in const expressions.
  const SliverSimpleGridDelegate();

  /// Returns the number of children than can be layout in the cross axis.
  int getCrossAxisCount(SliverConstraints constraints, double crossAxisSpacing);

  /// Override this method to return true when the children need to be
  /// laid out.
  ///
  /// This should compare the fields of the current delegate and the given
  /// `oldDelegate` and return true if the fields are such that the layout would
  /// be different.
  bool shouldRelayout(covariant SliverSimpleGridDelegate oldDelegate);
}

/// Creates grid layouts with a fixed number of tiles in the cross axis.
///
/// For example, if the grid is vertical, this delegate will create a layout
/// with a fixed number of columns. If the grid is horizontal, this delegate
/// will create a layout with a fixed number of rows.
///
/// This delegate creates grids with equally sized and spaced tiles.
class SliverSimpleGridDelegateWithFixedCrossAxisCount extends SliverSimpleGridDelegate {
  /// Creates a delegate that makes grid layouts with a fixed number of tiles in
  /// the cross axis.
  ///
  /// The [crossAxisCount] argument must be greater than zero.
  const SliverSimpleGridDelegateWithFixedCrossAxisCount({
    required this.crossAxisCount,
  }) : assert(crossAxisCount > 0);

  /// {@template fsgv.global.crossAxisCount}
  /// The number of children in the cross axis.
  /// {@endtemplate}
  final int crossAxisCount;

  @override
  int getCrossAxisCount(
    SliverConstraints constraints,
    double crossAxisSpacing,
  ) {
    return crossAxisCount;
  }

  @override
  bool shouldRelayout(
    SliverSimpleGridDelegateWithFixedCrossAxisCount oldDelegate,
  ) {
    return oldDelegate.crossAxisCount != crossAxisCount;
  }
}
