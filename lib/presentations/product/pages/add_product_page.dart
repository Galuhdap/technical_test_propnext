import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technical_test_propnext/core/components/appbar_component.dart';
import 'package:technical_test_propnext/core/components/buttons.dart';
import 'package:technical_test_propnext/core/extensions/sized_box_ext.dart';
import 'package:technical_test_propnext/core/styles/app_colors.dart';
import 'package:technical_test_propnext/presentations/product/provider/product_provider.dart';
import 'package:technical_test_propnext/presentations/product/widgets/form/product_form_fields.dart';
import 'package:technical_test_propnext/presentations/product/widgets/form/product_image_banner.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _stockController = TextEditingController();

  String? selectedCategory;
  final categories = ['Hardware', 'Software', 'Logistics', 'Maintenance'];

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _stockController.dispose();
    super.dispose();
  }

  Future<void> _saveProduct() async {
    if (!_formKey.currentState!.validate()) return;

    final provider = context.read<ProductProvider>();

    final success = await provider.createProduct(
      title: _nameController.text.trim(),
      description: _descriptionController.text.trim(),
      price: double.parse(_priceController.text),
      stock: int.parse(_stockController.text),
      category: selectedCategory!,
      thumbnail: 'https://images.unsplash.com/photo-1556742049-0cfed4f6a45d',
    );

    if (mounted) {
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColors.colorSuccesDefault,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            content: Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.white),
                8.width,
                Text('"${_nameController.text}" added successfully!'),
              ],
            ),
          ),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColors.colorDangerDefault,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            content: Row(
              children: [
                const Icon(Icons.error_outline, color: Colors.white),
                8.width,
                Expanded(
                  child: Text(
                    provider.submitError ?? 'Failed to add product',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProductProvider>();
    final isSubmitting = provider.isSubmitting;

    return Scaffold(
      backgroundColor: AppColors.colorGeneralBackground,
      appBar: AppbarComponent(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.colorGeneralBlack,
          ),
          onPressed: isSubmitting ? null : () => Navigator.pop(context),
        ),
        title: 'New Product',
        foregroundColor: AppColors.colorGeneralBlack,
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          color: Colors.white,
          child: Button.filled(
            onPressed: _saveProduct,
            disabled: isSubmitting,
            icon: isSubmitting
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Icon(Icons.save),
            label: isSubmitting ? 'Saving Product...' : 'Save Product',
            backgroundColor: AppColors.colorPrimary,
            foregroundColor: Colors.white,
            borderRadius: 16,
            height: 56,
            fontSize: 16,
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const ProductImageBanner(
                    label: 'DEFINE ASSET',
                    icon: Icons.add_circle_outline,
                  ),
                  32.height,
                  ProductFormFields(
                    nameController: _nameController,
                    descriptionController: _descriptionController,
                    priceController: _priceController,
                    stockController: _stockController,
                    selectedCategory: selectedCategory,
                    categories: categories,
                    isEnabled: !isSubmitting,
                    onCategoryChanged: (value) {
                      setState(() {
                        selectedCategory = value;
                      });
                    },
                  ),
                  40.height,
                ],
              ),
            ),
          ),
          if (isSubmitting)
            Container(
              color: Colors.black.withAlpha(30),
              child: const Center(
                child: Card(
                  elevation: 4,
                  shape: CircleBorder(),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(
                      color: AppColors.colorPrimary,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
