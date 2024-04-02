library ad_gridview;

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

enum AdGridViewType { once, repeated }

class AdGridView extends StatelessWidget {
  const AdGridView({
    this.padding,
    this.physics,
    this.itemMainAspectRatio = 1,
    required this.crossAxisCount,
    required this.itemCount,
    required this.adIndex,
    required this.adWidget,
    required this.itemWidget,
    this.adGridViewType = AdGridViewType.once,
    super.key,
  });

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

    /// for Repeated
    List indexList = [];
    int j = 0;
    for (int i = 0; i < itemCount; i++) {
      j++;
      indexList.add(i);
      if (j == adIndex * crossAxisCount) {
        indexList.add("ad");
        j = 0;
      }
    }

    return AdGridViewType.once == adGridViewType
        ? SingleChildScrollView(
            physics: physics,
            padding: padding,
            child: StaggeredGrid.count(
              crossAxisCount: crossAxisCount,
              children: List.generate(
                _itemCount,
                (index) {
                  return index == (crossAxisCount * adIndex)
                      ? StaggeredGridTile.fit(
                          crossAxisCellCount: crossAxisCount, child: adWidget)
                      : StaggeredGridTile.count(
                          crossAxisCellCount: 1,
                          mainAxisCellCount: itemMainAspectRatio! * 1,
                          child: itemWidget(
                              context,
                              index < (crossAxisCount * adIndex)
                                  ? index
                                  : (index - 1)),
                        );
                },
              ),
            ),
          )
        : SingleChildScrollView(
            physics: physics,
            padding: padding,
            child: StaggeredGrid.count(
              crossAxisCount: crossAxisCount,
              children: List.generate(
                indexList.length,
                (index) {
                  return indexList[index] == "ad"
                      ? StaggeredGridTile.fit(
                          crossAxisCellCount: crossAxisCount, child: adWidget)
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
