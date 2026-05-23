import 'package:flutter/material.dart';
import 'package:technical_test_propnext/core/components/buttons.dart';
import 'package:technical_test_propnext/core/extensions/sized_box_ext.dart';
import 'package:technical_test_propnext/core/styles/app_colors.dart';

class ProductErrorState extends StatelessWidget {
  final String errorMessage;
  final VoidCallback onRetry;

  const ProductErrorState({
    super.key,
    required this.errorMessage,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_outline_rounded,
                color: Colors.red.shade400,
                size: 48,
              ),
            ),
            16.height,
            Text(
              'Failed to Load Products',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF0F172A),
                  ),
            ),
            8.height,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                errorMessage,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
              ),
            ),
            24.height,
            Button.filled(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh, size: 18),
              label: 'Try Again',
              backgroundColor: AppColors.colorPrimary,
              foregroundColor: Colors.white,
              borderRadius: 12,
              width: 140,
            ),
          ],
        ),
      ),
    );
  }
}

