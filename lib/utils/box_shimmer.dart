import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

const double defaultPadding = 20;
Color baseColor = const Color.fromARGB(100, 24, 24, 24);
Color highlightColor = const Color.fromARGB(200, 24, 24, 24);

class Skeleton extends StatelessWidget {
  const Skeleton({super.key, this.height, this.width});

  final double? height, width;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Container(
        height: height,
        width: width,
        padding: const EdgeInsets.all(defaultPadding / 2),
        decoration: const BoxDecoration(
            color: Color.fromARGB(100, 24, 24, 24), borderRadius: BorderRadius.all(Radius.circular(defaultPadding))),
      ),
    );
  }
}

class ShimmerCard extends StatelessWidget {
  const ShimmerCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    highlightColor = theme.colorScheme.secondaryFixed;
    baseColor = theme.colorScheme.secondaryFixedDim.withOpacity(0.8);
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: SizedBox(height: 200, child: Skeleton()),
          ),
          Skeleton(width: 140),
          SizedBox(height: defaultPadding / 2),
          Skeleton(),
          SizedBox(height: defaultPadding / 2),
          Skeleton(),
          SizedBox(height: defaultPadding / 2)
        ],
      ),
    );
  }
}
