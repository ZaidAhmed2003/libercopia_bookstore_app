import 'package:flutter/material.dart';
import 'package:libercopia_bookstore_app/common/widgets/shimmers/shimmer.dart';

import '../../../utils/constants/sizes.dart';

class CategoryShimmer extends StatelessWidget {
  const CategoryShimmer({super.key, this.itemCount = 6});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 85,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: itemCount,
        padding: const EdgeInsets.only(right: LSizes.defaultSpace),
        scrollDirection: Axis.horizontal,
        itemExtent: 60,
        shrinkWrap: true,
        itemBuilder: (_, __) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              /// Image
              LShimmerEffect(width: 55, height: 55, radius: 55),
              SizedBox(height: LSizes.spaceBtwItems / 2),

              /// Text
              LShimmerEffect(width: 55, height: 8),
            ],
          );
        },
      ),
    );
  }
}
