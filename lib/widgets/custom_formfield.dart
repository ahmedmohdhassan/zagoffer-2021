import 'package:flutter/material.dart';
import 'package:zagoffer/constants/colors.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField(
      {this.focusNode,
      this.labelText,
      this.initialValue,
      this.maxLines,
      this.obscure = false,
      this.onChanged,
      this.onSaved,
      this.onSubmitted,
      this.textInputAction,
      this.textInputType,
      this.validator,
      this.suffixIconButton});

  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final String? labelText;
  final String? initialValue;
  final int? maxLines;
  final bool obscure;
  final Function? onChanged;
  final Function? onSubmitted;
  final Function? onSaved;
  final Function? validator;
  final IconButton? suffixIconButton;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator as String? Function(String?)?,
      onChanged: onChanged as void Function(String)?,
      maxLines: maxLines,
      onFieldSubmitted: onSubmitted as void Function(String)?,
      onSaved: onSaved as void Function(String?)?,
      focusNode: focusNode,
      textInputAction: textInputAction,
      keyboardType: textInputType,
      obscureText: obscure,
      initialValue: initialValue,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          color: Colors.grey[500],
        ),
        enabled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(50),
          ),
          borderSide: BorderSide(
            color: white,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(50),
          ),
          borderSide: BorderSide(
            color: red,
            width: 1,
          ),
        ),
        focusColor: Colors.blue,
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(50),
          ),
          borderSide: BorderSide(
            color: white,
            width: 2,
          ),
        ),
        suffixIcon: suffixIconButton,
        filled: true,
        fillColor: Colors.transparent,
      ),
    );
  }
}
