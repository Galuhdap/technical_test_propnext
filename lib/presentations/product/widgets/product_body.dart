import 'package:flutter/material.dart';
import 'package:technical_test_propnext/domain/entities/product.dart';
import 'package:technical_test_propnext/presentations/product/provider/product_provider.dart';
import 'package:technical_test_propnext/presentations/product/widgets/product_card.dart';
import 'package:technical_test_propnext/presentations/product/widgets/product_empty_state.dart';
import 'package:technical_test_propnext/presentations/product/widgets/product_error_state.dart';
import 'package:technical_test_propnext/presentations/product/widgets/product_skeleton_card.dart';

class ProductBody extends StatelessWidget {
  final ProductProvider provider;
  final ScrollController scrollController;
  final Future<void> Function() onRefresh;
  final void Function(Product product) onTapProduct;
  final VoidCallback onAddProduct;

  const ProductBody({
    super.key,
    required this.provider,
    required this.scrollController,
    required this.onRefresh,
    required this.onTapProduct,
    required this.onAddProduct,
  });

  @override
  Widget build(BuildContext context) {
    if (provider.isLoading && provider.products.isEmpty) {
      return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 5,
        itemBuilder: (context, index) => const ProductSkeletonCard(),
      );
    }

    if (provider.errorMessage != null && provider.products.isEmpty) {
      return ProductErrorState(
        errorMessage: provider.errorMessage!,
        onRetry: onRefresh,
      );
    }

    if (provider.products.isEmpty) {
      return ProductEmptyState(
        searchQuery: provider.searchQuery,
        onClearSearch: () => provider.clearSearch(),
        onAddProduct: onAddProduct,
      );
    }

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.builder(
        controller: scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 100),
        itemCount: provider.products.length + (provider.hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == provider.products.length) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 24.0),
              child: Center(
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(strokeWidth: 2.5),
                ),
              ),
            );
          }

          final product = provider.products[index];
          return ProductCard(
            product: product,
            onTap: () => onTapProduct(product),
            // onConfirmDismiss: (direction) => onConfirmDismiss(product),
            //  onDismissed: (direction) => onDismissed(product),
          );
        },
      ),
    );
  }
}
