library ad_gridview;

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

/// A widget that displays a grid view with advertisements at specific intervals.
///
/// The [AdGridView] widget is designed to display a grid view of items with advertisements inserted
/// at regular intervals or custom positions. It supports three types of grid layouts: [AdGridViewType.once],
/// [AdGridViewType.repeated], and [AdGridViewType.custom].
enum AdGridViewType { once, repeated, custom }

///
/// The [padding], [physics], [controller], [customAdIndex], [itemMainAspectRatio] parameters
/// allow further customization of the grid view.
class AdGridView extends StatelessWidget {
  /// Creates a [AdGridView] widget.
  ///
  /// The [crossAxisCount] parameter specifies the number of items in each row.
  ///
  /// The [itemCount] parameter specifies the total number of items in the grid.
  ///
  /// The [adIndex] parameter specifies the position where advertisements should be inserted.
  ///
  /// The [adWidget] parameter is the widget to be displayed as an advertisement.
  ///
  /// The [itemWidget] parameter is a callback function that builds the widgets for grid items.
  ///
  /// The [adGridViewType] parameter specifies the type of grid layout to use:
  ///   - [AdGridViewType.once] adds a single advertisement at the specified index.
  ///   - [AdGridViewType.repeated] adds advertisements at regular intervals.
  ///   - [AdGridViewType.custom] allows customizing the positions of advertisements.
  const AdGridView({
    this.padding,
    this.physics,
    this.controller,
    this.customAdIndex = const [],
    this.itemMainAspectRatio = 1,
    required this.crossAxisCount,
    required this.itemCount,
    required this.adIndex,
    required this.adWidget,
    required this.itemWidget,
    this.adGridViewType = AdGridViewType.once,
    Key? key,
  }) : super(key: key);

  final List customAdIndex;
  final ScrollController? controller;
  final AdGridViewType adGridViewType;
  final EdgeInsetsGeometry? padding;
  final ScrollPhysics? physics;
  final double? itemMainAspectRatio;
  final int crossAxisCount;
  final int itemCount;
  final int adIndex;
  final Widget adWidget;
  final Widget Function(BuildContext context, int index) itemWidget;

  @override
  Widget build(BuildContext context) {
    /// for Once
    int _itemCount = 0;
    if (itemCount < (crossAxisCount * adIndex)) {
      _itemCount = itemCount;
    } else {
      _itemCount = itemCount + 1;
    }

    List indexList = [];
    if (AdGridViewType.repeated == adGridViewType) {
      /// for Repeated
      int j = 0;
      for (int i = 0; i < itemCount; i++) {
        j++;
        indexList.add(i);
        if (j == adIndex * crossAxisCount) {
          indexList.add("ad");
          j = 0;
        }
      }
    } else if (AdGridViewType.custom == adGridViewType) {
      /// for Custom
      if (customAdIndex.isEmpty) {
        throw Exception('You are using AdGridViewType.custom so provide a List<index> in customAdIndex parameter');
      }
      List _customAdIndex = customAdIndex;
      int j = 0;
      for (int i = 0; i < itemCount; i++) {
        if (i % crossAxisCount == 0) {
          j = i ~/ crossAxisCount;
          if (_customAdIndex.contains(j)) {
            _customAdIndex.remove(j);
            indexList.add("ad");
          }
        }
        indexList.add(i);
      }
    }

    return AdGridViewType.once == adGridViewType
        ? SingleChildScrollView(
            controller: controller,
            physics: physics,
            padding: padding,
            child: StaggeredGrid.count(
              crossAxisCount: crossAxisCount,
              children: List.generate(
                _itemCount,
                (index) {
                  return index == (crossAxisCount * adIndex)
                      ? StaggeredGridTile.fit(crossAxisCellCount: crossAxisCount, child: adWidget)
                      : StaggeredGridTile.count(
                          crossAxisCellCount: 1,
                          mainAxisCellCount: itemMainAspectRatio! * 1,
                          child: itemWidget(context, index < (crossAxisCount * adIndex) ? index : (index - 1)),
                        );
                },
              ),
            ),
          )
        : SingleChildScrollView(
            controller: controller,
            physics: physics,
            padding: padding,
            child: StaggeredGrid.count(
              crossAxisCount: crossAxisCount,
              children: List.generate(
                indexList.length,
                (index) {
                  return indexList[index] == "ad"
                      ? StaggeredGridTile.fit(crossAxisCellCount: crossAxisCount, child: adWidget)
                      : StaggeredGridTile.count(
                          crossAxisCellCount: 1,
                          mainAxisCellCount: itemMainAspectRatio! * 1,
                          child: itemWidget(context, indexList[index]),
                        );
                },
              ),
            ),
          );
  }
}
