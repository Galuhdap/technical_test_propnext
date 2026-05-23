import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technical_test_propnext/core/components/appbar_component.dart';
import 'package:technical_test_propnext/core/components/buttons.dart';
import 'package:technical_test_propnext/core/extensions/sized_box_ext.dart';
import 'package:technical_test_propnext/core/styles/app_colors.dart';
import 'package:technical_test_propnext/domain/entities/product.dart';
import 'package:technical_test_propnext/presentations/product/provider/product_provider.dart';
import 'package:technical_test_propnext/presentations/product/widgets/form/product_form_fields.dart';
import 'package:technical_test_propnext/presentations/product/widgets/form/product_image_banner.dart';

class UpdateProductPage extends StatefulWidget {
  final Product product;

  const UpdateProductPage({super.key, required this.product});

  @override
  State<UpdateProductPage> createState() => _UpdateProductPageState();
}

class _UpdateProductPageState extends State<UpdateProductPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _priceController;
  late final TextEditingController _stockController;

  String? selectedCategory;
  final categories = ['Hardware', 'Software', 'Logistics', 'Maintenance'];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.product.title);
    _descriptionController = TextEditingController(
      text: widget.product.description,
    );
    _priceController = TextEditingController(
      text: widget.product.price.toString(),
    );
    _stockController = TextEditingController(
      text: widget.product.stock.toString(),
    );
    selectedCategory = categories.contains(widget.product.category)
        ? widget.product.category
        : categories.first;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _stockController.dispose();
    super.dispose();
  }

  Future<void> _updateProduct() async {
    if (!_formKey.currentState!.validate()) return;

    final provider = context.read<ProductProvider>();

    final success = await provider.editProduct(
      id: widget.product.id,
      title: _nameController.text.trim(),
      description: _descriptionController.text.trim(),
      price: double.parse(_priceController.text),
      stock: int.parse(_stockController.text),
      category: selectedCategory!,
      thumbnail: widget.product.thumbnail,
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
                Text('Updated successfully!'),
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
                    provider.submitError ?? 'Failed to update product',
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

  Future<void> _deleteProduct() async {
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
          'Are you sure you want to delete "${widget.product.title}"? This action cannot be undone.',
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

    if (confirm == true && mounted) {
      final success = await context.read<ProductProvider>().removeProduct(
        widget.product.id,
      );

      if (mounted) {
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
                      ? 'Product "${widget.product.title}" deleted'
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
        title: 'Edit Product',
        foregroundColor: AppColors.colorGeneralBlack,
        actions: [
          IconButton(
            onPressed: isSubmitting ? null : _deleteProduct,
            icon: const Icon(
              Icons.delete_outline_rounded,
              color: AppColors.colorDangerDefault,
            ),
            tooltip: 'Delete Product',
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          color: Colors.white,
          child: Button.filled(
            onPressed: _updateProduct,
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
            label: isSubmitting ? 'Saving Changes...' : 'Save Changes',
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
                  ProductImageBanner(
                    imageUrl: widget.product.thumbnail,
                    label: 'EDIT ASSET',
                    icon: Icons.edit_note_outlined,
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
              color: Colors.black.withOpacity(0.1),
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
