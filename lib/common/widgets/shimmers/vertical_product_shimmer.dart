import 'package:flutter/material.dart';
import 'package:libercopia_bookstore_app/common/widgets/shimmers/shimmer.dart';

import '../../../utils/constants/sizes.dart';
import '../layout/grid_layout.dart';

class LVerticalProductShimmer extends StatelessWidget {
  const LVerticalProductShimmer({super.key, this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return LGridLayout(
      itemCount: itemCount,
      itemBuilder:
          (_, index) => const SizedBox(
            width: 180,
            child: Column(
              children: [
                /// Image
                LShimmerEffect(width: 180, height: 180),
                SizedBox(height: LSizes.spaceBtwItems),

                /// Text
                LShimmerEffect(width: 160, height: 15),
                SizedBox(height: LSizes.spaceBtwItems),
                LShimmerEffect(width: 110, height: 15),
              ],
            ),
          ),
    );
  }
}
