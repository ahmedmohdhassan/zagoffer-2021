import 'package:flutter/material.dart';

class SliderItem extends StatelessWidget {
  const SliderItem({
    required this.imageUrl,
    required this.id,
    required this.type,
    this.onPressed,
  });
  final String? imageUrl;
  final String? id;
  final int? type;
  final Function? onPressed;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(
        Radius.circular(10),
      ),
      child: GestureDetector(
        onTap: onPressed as void Function()?,
        child: Container(
          width: double.infinity,
          child: Image.network(
            imageUrl!,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
