import 'package:flutter/material.dart';
import 'package:technical_test_propnext/core/extensions/sized_box_ext.dart';
import 'package:technical_test_propnext/core/styles/app_colors.dart';
import 'package:technical_test_propnext/domain/entities/product.dart';

class ProductHeader extends StatelessWidget {
  final Product product;

  const ProductHeader({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.category.toUpperCase(),
                    style: const TextStyle(
                      color: AppColors.colorPrimary,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      fontSize: 12,
                    ),
                  ),
                  4.height,
                  Text(
                    product.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.colorGeneralBlack,
                    ),
                  ),
                ],
              ),
            ),
            12.width,
            Text(
              '\$${product.price.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0050CB),
              ),
            ),
          ],
        ),
        12.height,
        Text(
          product.description,
          style: const TextStyle(
            height: 1.6,
            color: AppColors.colorGeneralGrey,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
