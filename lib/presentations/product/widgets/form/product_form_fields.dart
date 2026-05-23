import 'package:flutter/material.dart';
import 'package:technical_test_propnext/core/components/input_component.dart';
import 'package:technical_test_propnext/core/extensions/sized_box_ext.dart';
import 'package:technical_test_propnext/core/styles/app_colors.dart';

class ProductFormFields extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final TextEditingController priceController;
  final TextEditingController stockController;
  final String? selectedCategory;
  final ValueChanged<String?> onCategoryChanged;
  final List<String> categories;
  final bool isEnabled;

  const ProductFormFields({
    super.key,
    required this.nameController,
    required this.descriptionController,
    required this.priceController,
    required this.stockController,
    required this.selectedCategory,
    required this.onCategoryChanged,
    required this.categories,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          controller: nameController,
          readOnly: !isEnabled,
          keyboardType: TextInputType.text,
          hintText: 'Product Name (e.g. Kinetic Server Rack v4)',
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Product name is required';
            }
            return null;
          },
        ),
        20.height,

        DropdownButtonFormField<String>(
          initialValue: selectedCategory,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            labelText: 'Category',
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: AppColors.colorGeneralOutline,
                width: 2,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: AppColors.colorGeneralOutline,
                width: 1,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 13,
            ),
          ),
          items: categories
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: isEnabled ? onCategoryChanged : null,
          validator: (value) {
            if (value == null) {
              return 'Category is required';
            }
            return null;
          },
        ),
        20.height,
        CustomTextField(
          controller: priceController,
          readOnly: !isEnabled,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          hintText: 'Price (in \$)',
          validator: (value) {
            final price = double.tryParse(value ?? '');
            if (price == null) {
              return 'Please enter a valid price';
            }
            if (price <= 0) {
              return 'Price must be greater than 0';
            }
            return null;
          },
        ),
        20.height,
        CustomTextField(
          controller: stockController,
          readOnly: !isEnabled,
          keyboardType: TextInputType.number,
          hintText: 'Stock Quantity',
          validator: (value) {
            final stock = int.tryParse(value ?? '');
            if (stock == null) {
              return 'Enter valid stock';
            }
            if (stock < 0) {
              return 'Stock cannot be negative';
            }
            return null;
          },
        ),
        20.height,
        CustomTextField(
          controller: descriptionController,
          readOnly: !isEnabled,
          maxLines: 3,
          keyboardType: TextInputType.multiline,
          hintText: 'Enter product description details...',
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Description is required';
            }
            return null;
          },
        ),
      ],
    );
  }
}
