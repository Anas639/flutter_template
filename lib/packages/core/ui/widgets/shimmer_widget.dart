import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// A widget that displays a shimmer effect
class ShimmerWidget extends StatelessWidget {
  final double? width;
  final double? height;

  const ShimmerWidget({super.key, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
      highlightColor: Colors.white30,
      child: Container(
        width: width,
        height: height,
        color: Colors.white,
      ),
    );
  }
}
