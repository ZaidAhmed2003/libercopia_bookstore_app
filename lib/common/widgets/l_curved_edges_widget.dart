import 'package:flutter/material.dart';

import 'l_custom_curved_edges.dart';

class LCurvedEdgesWidget extends StatelessWidget {
  const LCurvedEdgesWidget({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(clipper: LCustomCurvedEdges(), child: child);
  }
}
