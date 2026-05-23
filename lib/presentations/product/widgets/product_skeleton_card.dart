import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:technical_test_propnext/core/extensions/sized_box_ext.dart';

class ProductSkeletonCard extends StatelessWidget {
  const ProductSkeletonCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Shimmer(
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            12.width,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Shimmer(
                    child: Container(
                      width: 140,
                      height: 16,
                      color: Colors.grey.shade200,
                    ),
                  ),
                  8.height,
                  Shimmer(
                    child: Container(
                      width: 90,
                      height: 12,
                      color: Colors.grey.shade200,
                    ),
                  ),
                  16.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Shimmer(
                        child: Container(
                          width: 60,
                          height: 20,
                          color: Colors.grey.shade200,
                        ),
                      ),
                      Shimmer(
                        child: Container(
                          width: 40,
                          height: 14,
                          color: Colors.grey.shade200,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

