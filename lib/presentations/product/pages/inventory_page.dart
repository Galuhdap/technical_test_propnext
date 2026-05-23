import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technical_test_propnext/core/components/appbar_component.dart';
import 'package:technical_test_propnext/core/components/input_component.dart';
import 'package:technical_test_propnext/core/extensions/sized_box_ext.dart';
import 'package:technical_test_propnext/core/styles/app_colors.dart';
import 'package:technical_test_propnext/presentations/product/pages/add_product_page.dart';
import 'package:technical_test_propnext/presentations/product/pages/detail_product_page.dart';
import 'package:technical_test_propnext/presentations/product/provider/product_provider.dart';
import 'package:technical_test_propnext/presentations/product/widgets/product_body.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _searchController.addListener(_onSearchQueryChanged);

    // Initial load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductProvider>().loadProducts(refresh: true);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<ProductProvider>().loadProducts();
    }
  }

  void _onSearchQueryChanged() {
    setState(() {}); // Refresh clear icon button
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      context.read<ProductProvider>().search(_searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProductProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppbarComponent(
        backgroundColor: AppColors.colorBgWeek,
        elevation: 0,
        titleWidget: Row(
          children: [
            Icon(Icons.inventory_2_outlined, color: AppColors.colorPrimary),
            8.width,
            Text(
              'Inventory',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.colorPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            16.height,
            CustomTextField(
              controller: _searchController,
              keyboardType: TextInputType.text,
              hintText: 'Search products...',
              prefixIcon: const Icon(Icons.search),
            ),
            16.height,
            Expanded(
              child: ProductBody(
                provider: provider,
                scrollController: _scrollController,
                onRefresh: () =>
                    context.read<ProductProvider>().loadProducts(refresh: true),
                onTapProduct: (product) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProductDetailPage(product: product),
                    ),
                  );
                },
                onAddProduct: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AddProductPage()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.colorPrimary,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddProductPage()),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
