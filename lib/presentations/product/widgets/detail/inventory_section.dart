import 'package:flutter/material.dart';
import 'package:technical_test_propnext/core/extensions/sized_box_ext.dart';
import 'package:technical_test_propnext/core/styles/app_colors.dart';
import 'package:technical_test_propnext/domain/entities/product.dart';

class InventorySection extends StatelessWidget {
  final Product product;

  const InventorySection({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final stock = product.stock;
    final isOutOfStock = product.isOutOfStock;
    final isLowStock = product.isLowStock;

    // Calculate indicator progress value (0.0 to 1.0)
    // Assume 50+ is 100% capacity
    final double progress = (stock / 50.0).clamp(0.0, 1.0);

    final Color statusColor = isOutOfStock
        ? AppColors.colorDangerDefault
        : isLowStock
            ? AppColors.colorWarningDefault
            : AppColors.colorPrimary;

    final String infoMessage = isOutOfStock
        ? 'Product is out of stock! Restock immediately.'
        : isLowStock
            ? 'Reorder point reached. Current stock is low.'
            : 'Inventory level is healthy and stable.';

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: statusColor.withAlpha(20),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: statusColor.withAlpha(40)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Inventory Status',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: AppColors.colorGeneralBlack,
                      ),
                    ),
                    4.height,
                    const Text(
                      'Warehouse: Central Distribution A',
                      style: TextStyle(
                        color: AppColors.colorGeneralGrey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '$stock',
                      style: TextStyle(
                        color: statusColor,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const TextSpan(
                      text: ' UNITS',
                      style: TextStyle(
                        color: AppColors.colorGeneralGrey,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          20.height,
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(statusColor),
            ),
          ),
          12.height,
          Row(
            children: [
              Icon(Icons.info_outline, size: 16, color: statusColor),
              4.width,
              Expanded(
                child: Text(
                  infoMessage,
                  style: TextStyle(
                    color: isOutOfStock
                        ? AppColors.colorDangerDefault
                        : isLowStock
                            ? AppColors.colorWarningDefaultStrong
                            : AppColors.colorGeneralGrey,
                    fontSize: 12,
                    fontWeight: isLowStock || isOutOfStock ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
