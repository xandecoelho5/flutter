import 'dart:math';

import 'package:flutter/material.dart';

class ProfileTab extends SliverPersistentHeaderDelegate {
  final TabBar child;

  ProfileTab(this.child);

  @override
  Widget build(context, double shrinkOffset, bool overlapsContent) {
    return SizedBox(
      height: max(minExtent, maxExtent - shrinkOffset),
      child: child,
    );
  }

  @override
  double get maxExtent => child.preferredSize.height;

  @override
  double get minExtent => child.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => false;
}
