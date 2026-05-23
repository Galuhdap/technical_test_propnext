import 'package:flutter/material.dart';
import 'package:technical_test_propnext/core/extensions/sized_box_ext.dart';
import 'package:technical_test_propnext/core/styles/app_colors.dart';

class ProductImageBanner extends StatelessWidget {
  final String? imageUrl;
  final String label;
  final IconData icon;

  const ProductImageBanner({
    super.key,
    this.imageUrl,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    const defaultImage = 'https://images.unsplash.com/photo-1556742049-0cfed4f6a45d';
    final imageToShow = (imageUrl == null || imageUrl!.isEmpty) ? defaultImage : imageUrl!;

    return Container(
      height: 220,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(imageToShow),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.colorGeneralGrey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.9),
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: AppColors.colorPrimary),
              8.width,
              Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  color: AppColors.colorGeneralBlack,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
