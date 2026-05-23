import 'package:flutter/material.dart';
import 'package:technical_test_propnext/core/components/buttons.dart';
import 'package:technical_test_propnext/core/extensions/sized_box_ext.dart';
import 'package:technical_test_propnext/core/styles/app_colors.dart';

class ProductEmptyState extends StatelessWidget {
  final String searchQuery;
  final VoidCallback onClearSearch;
  final VoidCallback onAddProduct;

  const ProductEmptyState({
    super.key,
    required this.searchQuery,
    required this.onClearSearch,
    required this.onAddProduct,
  });

  @override
  Widget build(BuildContext context) {
    final isSearching = searchQuery.isNotEmpty;

    return Center(
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                shape: BoxShape.circle,
              ),
              child: Icon(
                isSearching ? Icons.search_off_rounded : Icons.inventory_2_outlined,
                color: Colors.grey.shade400,
                size: 48,
              ),
            ),
            16.height,
            Text(
              isSearching ? 'No Products Found' : 'Your Inventory is Empty',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF0F172A),
                  ),
            ),
            8.height,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                isSearching
                    ? 'No products matched your search "$searchQuery".'
                    : 'Get started by adding your first product.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey.shade500),
              ),
            ),
            24.height,
            if (isSearching)
              Button.outlined(
                onPressed: onClearSearch,
                icon: const Icon(Icons.clear_all, size: 18),
                label: 'Clear Search',
                foregroundColor: AppColors.colorPrimary,
                borderRadius: 12,
                width: 160,
              )
            else
              Button.filled(
                onPressed: onAddProduct,
                icon: const Icon(Icons.add, size: 18),
                label: 'Add Product',
                backgroundColor: AppColors.colorPrimary,
                foregroundColor: Colors.white,
                borderRadius: 12,
                width: 160,
              ),
          ],
        ),
      ),
    );
  }
}

