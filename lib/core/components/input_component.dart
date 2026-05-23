import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:technical_test_propnext/config/theme_config.dart';
import 'package:technical_test_propnext/core/styles/app_colors.dart';
import 'package:technical_test_propnext/core/styles/app_sizes.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController _controller;
  final String? label;
  final String? hintText;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final bool isObscure;
  final bool suffixIcon;
  final Color fillColor;
  final AutovalidateMode? autovalidateMode;
  final VoidCallback? onTap;
  final bool readOnly;
  final TextStyle? hintStyle;
  final Color enabledBorderColor;
  final double? enabledBorderWidth;
  final Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final double topLeft;
  final double bottomLeft;
  final double topRight;
  final double bottomRight;
  final String? errorText;
  final int maxLines;

  const CustomTextField({
    Key? key,
    required TextEditingController controller,
    this.label,
    this.hintText,
    required this.keyboardType,
    this.prefixIcon,
    this.validator,
    this.isObscure = false,
    this.suffixIcon = false,
    this.autovalidateMode,
    this.onTap,
    this.fillColor = Colors.white,
    this.hintStyle,
    this.enabledBorderColor = AppColors.colorGeneralOutline,
    this.enabledBorderWidth,
    this.onChanged,
    this.inputFormatters,
    this.readOnly = false,
    this.bottomLeft = 10,
    this.bottomRight = 10,
    this.topLeft = 10,
    this.topRight = 10,
    this.errorText,
    this.maxLines = 1,
  }) : _controller = controller,
       super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isObscurePwd = false;

  @override
  void initState() {
    setState(() {
      isObscurePwd = widget.isObscure;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: widget.maxLines,
      readOnly: widget.readOnly,
      controller: widget._controller,
      onTap: widget.onTap,
      validator: widget.validator,
      obscureText: isObscurePwd,
      autovalidateMode: widget.autovalidateMode,
      keyboardType: widget.keyboardType,
      onChanged: widget.onChanged,
      inputFormatters: widget.inputFormatters,
      decoration: InputDecoration(
        filled: true,
        fillColor: widget.fillColor,
        errorText: widget.errorText,
        hintText: widget.hintText,
        hintStyle:
            widget.hintStyle ??
            ThemeConfig.bodyMedium.copyWith(
              fontWeight: FontWeight.w400,
              color: AppColors.colorGeneralPlaceHolder,
              fontSize: 14,
            ),
        prefixIcon: widget.prefixIcon,
        suffixIcon: !widget.suffixIcon
            ? null
            : IconButton(
                icon: Icon(
                  isObscurePwd ? Icons.visibility : Icons.visibility_off,
                  color: isObscurePwd
                      ? ThemeConfig.neutral70
                      : ThemeConfig.neutral50,
                ),
                onPressed: () {
                  setState(() {
                    isObscurePwd = !isObscurePwd;
                  });
                },
              ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(widget.topLeft),
            topRight: Radius.circular(widget.topRight),
            bottomLeft: Radius.circular(widget.bottomLeft),
            bottomRight: Radius.circular(widget.bottomRight),
          ),
          //borderRadius: BorderRadius.circular(AppSizes.s10),
          borderSide: BorderSide(
            color: AppColors.colorGeneralOutline,
            width: AppSizes.s2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.enabledBorderColor,
            width: widget.enabledBorderWidth ?? AppSizes.s1,
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(widget.topLeft),
            topRight: Radius.circular(widget.topRight),
            bottomLeft: Radius.circular(widget.bottomLeft),
            bottomRight: Radius.circular(widget.bottomRight),
          ),
        ),
        contentPadding: AppSizes.symmetricPadding(
          horizontal: AppSizes.s16,
          vertical: AppSizes.s13,
        ),
      ),
      cursorColor: AppColors.colorGeneralBlack,
      style: ThemeConfig.bodyMedium.copyWith(
        fontWeight: FontWeight.w400,
        //  color: AppColors.colorNeutrals500,
        fontSize: 14,
      ),
    );
  }
}
