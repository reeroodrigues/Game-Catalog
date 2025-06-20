import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class GameCardShimmer extends StatelessWidget {
  const GameCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade800,
      highlightColor: Colors.grey.shade700,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                color: Colors.grey,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
