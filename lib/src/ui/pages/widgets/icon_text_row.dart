import 'package:flutter/widgets.dart';

class IconTextRow extends StatelessWidget {
  final Icon icon;
  final String text;
  final bool center;
  final Color? textColor;
  const IconTextRow({
    super.key, required this.icon, required this.text, this.center =false, this.textColor
  });

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: center? MainAxisAlignment.center: MainAxisAlignment.start,
        children: [
      icon,
      const SizedBox(width: 6),
      Text(text, style: TextStyle(color: textColor))
    ]);
  }
}