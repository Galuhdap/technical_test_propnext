import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:technical_test_propnext/core/components/appbar_component.dart';
import 'package:technical_test_propnext/core/components/buttons.dart';
import 'package:technical_test_propnext/core/extensions/sized_box_ext.dart';
import 'package:technical_test_propnext/core/styles/app_colors.dart';
import 'package:technical_test_propnext/domain/entities/product.dart';
import 'package:technical_test_propnext/presentations/product/pages/update_product_page.dart';
import 'package:technical_test_propnext/presentations/product/provider/product_provider.dart';
import 'package:technical_test_propnext/presentations/product/widgets/detail/inventory_section.dart';
import 'package:technical_test_propnext/presentations/product/widgets/detail/spesification_grid.dart';
import 'package:technical_test_propnext/presentations/product/widgets/header_product.dart';
import 'package:technical_test_propnext/presentations/product/widgets/product_image_section.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  void _shareProduct(BuildContext context, Product activeProduct) {
    final box = context.findRenderObject() as RenderBox?;
    Share.share(
      'Check out this product: ${activeProduct.title}\n'
      'Category: ${activeProduct.category}\n'
      'Price: \$${activeProduct.price.toStringAsFixed(2)}\n'
      'Stock: ${activeProduct.stock} units\n\n'
      'Description: ${activeProduct.description}',
      subject: activeProduct.title,
      sharePositionOrigin: box != null ? box.localToGlobal(Offset.zero) & box.size : null,
    );
  }

  Future<void> _deleteProduct(
    BuildContext context,
    Product activeProduct,
  ) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Delete Product',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.colorGeneralBlack,
          ),
        ),
        content: Text(
          'Are you sure you want to delete "${activeProduct.title}"? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Button.filled(
            width: 100,
            backgroundColor: AppColors.colorDangerDefault,
            onPressed: () => Navigator.pop(context, true),
            label: 'Delete',
            foregroundColor: Colors.white,
          ),
        ],
      ),
    );

    if (confirm == true && context.mounted) {
      final success = await context.read<ProductProvider>().removeProduct(
        activeProduct.id,
      );

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: success
                ? AppColors.colorSuccesDefault
                : AppColors.colorDangerDefault,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            content: Row(
              children: [
                Icon(
                  success ? Icons.check_circle : Icons.error_outline,
                  color: Colors.white,
                ),
                8.width,
                Text(
                  success
                      ? 'Product "${activeProduct.title}" deleted'
                      : 'Failed to delete product',
                ),
              ],
            ),
          ),
        );

        if (success) {
          Navigator.pop(context);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProductProvider>();

    final hasProduct = provider.products.any((p) => p.id == product.id);

    if (!hasProduct) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
      });
      return const Scaffold(
        backgroundColor: AppColors.colorGeneralBackground,
        body: SizedBox.shrink(),
      );
    }

    final activeProduct = provider.products.firstWhere(
      (p) => p.id == product.id,
    );

    return Scaffold(
      backgroundColor: AppColors.colorGeneralBackground,
      appBar: AppbarComponent(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: false,
        title: 'Product Details',
        foregroundColor: AppColors.colorPrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: AppColors.colorPrimary,
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined),
            color: AppColors.colorPrimary,
            onPressed: () => _shareProduct(context, activeProduct),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(color: AppColors.colorGeneralOutline),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Button.filled(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            UpdateProductPage(product: activeProduct),
                      ),
                    );
                  },
                  icon: const Icon(Icons.edit, size: 18),
                  label: 'Edit Product',
                  backgroundColor: AppColors.colorPrimary,
                  foregroundColor: Colors.white,
                  borderRadius: 16,
                  height: 52,
                  fontSize: 14,
                ),
              ),
              12.width,
              IconButton(
                onPressed: () => _deleteProduct(context, activeProduct),
                icon: const Icon(
                  Icons.delete_outline_rounded,
                  color: AppColors.colorDangerDefault,
                  size: 28,
                ),
                tooltip: 'Delete Product',
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ProductImage(product: activeProduct),
            24.height,
            ProductHeader(product: activeProduct),
            24.height,
            SpecificationGrid(product: activeProduct),
            24.height,
            InventorySection(product: activeProduct),
            80.height,
          ],
        ),
      ),
    );
  }
}
