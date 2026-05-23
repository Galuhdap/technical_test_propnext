import 'package:flutter/material.dart';
import 'package:technical_test_propnext/core/extensions/sized_box_ext.dart';
import 'package:technical_test_propnext/core/styles/app_colors.dart';
import 'package:technical_test_propnext/domain/entities/product.dart';

class ProductImage extends StatelessWidget {
  final Product product;

  const ProductImage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final bool isOutOfStock = product.isOutOfStock;
    final bool isLowStock = product.isLowStock;

    final Color statusColor = isOutOfStock
        ? AppColors.colorDangerDefault
        : isLowStock
            ? AppColors.colorWarningDefault
            : AppColors.colorSuccesDefault;

    final String statusText = isOutOfStock
        ? 'Out of Stock'
        : isLowStock
            ? 'Low Stock'
            : 'In Stock';

    final IconData statusIcon = isOutOfStock
        ? Icons.cancel
        : isLowStock
            ? Icons.warning
            : Icons.check_circle;

    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 1.2,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.colorGeneralOutline),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(10),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                product.thumbnail,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Icon(
                      Icons.image_not_supported_outlined,
                      size: 64,
                      color: AppColors.colorGeneralPlaceHolder,
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        Positioned(
          top: 16,
          right: 16,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: statusColor.withAlpha(30),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(statusIcon, size: 16, color: statusColor),
                4.width,
                Text(
                  statusText,
                  style: TextStyle(
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
