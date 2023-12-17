import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem({
    this.icon,
    this.text,
    this.onPressed,
    this.iconColor,
  });

  final Function? onPressed;
  final String? text;
  final IconData? icon;
  final Color? iconColor;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: Colors.black26,
      onTap: onPressed as void Function()?,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          children: [
            Icon(
              Icons.arrow_back_ios_outlined,
              color: Colors.black45,
              size: 20,
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  text!,
                  softWrap: true,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  icon,
                  color: iconColor == null
                      ? Theme.of(context).colorScheme.secondary
                      : iconColor,
                  size: 25,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
