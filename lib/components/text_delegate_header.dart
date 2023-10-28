import 'package:flutter/material.dart';
import 'package:test_udemy_amazon_clone2/styles/styles.dart';

class TextDelegateHeader extends SliverPersistentHeaderDelegate {
  TextDelegateHeader({this.title});

  String? title;

  ///
  @override
  Widget build(
    BuildContext context,
    double shrinkOffSet,
    bool overlapsContent,
  ) {
    return InkWell(
      child: Container(
        decoration: pinkBackGround,
        height: 82,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        child: InkWell(
          child: Text(
            title.toString(),
            maxLines: 2,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 22,
              letterSpacing: 3,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => 50;

  @override
  // TODO: implement minExtent
  double get minExtent => 50;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => true;
}
