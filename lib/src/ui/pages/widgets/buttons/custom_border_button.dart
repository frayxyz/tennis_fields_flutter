import 'package:flutter/material.dart';

class CustomBorderButton extends StatelessWidget {
  final Widget child;
  final Color? borderColor;
  final void Function() onPressed;
  const CustomBorderButton(
      {super.key,
      required this.child,
      this.borderColor,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsetsDirectional.symmetric(vertical: 8),
          decoration: BoxDecoration(
            border: borderColor != null
                ? Border.all(color: borderColor!)
                : Border.all(),
            borderRadius: BorderRadius.circular(7),
          ),
          child: child),
    );
  }
}
