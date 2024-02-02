library ad_gridview;

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

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
    super.key,
  });

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
    int _itemCount = 0;
    if (itemCount < (crossAxisCount * adIndex)) {
      _itemCount = itemCount;
    } else {
      _itemCount = itemCount + 1;
    }

    return SingleChildScrollView(
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
    );
  }
}
