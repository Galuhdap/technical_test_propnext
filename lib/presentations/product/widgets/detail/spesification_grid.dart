import 'package:flutter/material.dart';
import 'package:technical_test_propnext/domain/entities/product.dart';
import 'package:technical_test_propnext/presentations/product/widgets/detail/spec_card.dart';

class SpecificationGrid extends StatelessWidget {
  final Product product;

  const SpecificationGrid({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 2.2,
      children: [
        SpecCard(title: 'SKU', value: 'PROD-${product.id}'),
        SpecCard(title: 'Category', value: product.category),
        SpecCard(title: 'Price', value: '\$${product.price.toStringAsFixed(2)}'),
        SpecCard(title: 'Stock Quantity', value: '${product.stock} units'),
      ],
    );
  }
}
