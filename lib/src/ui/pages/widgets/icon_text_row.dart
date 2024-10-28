import 'package:flutter/widgets.dart';

class IconTextRow extends StatelessWidget {
  final Icon icon;
  final String text;
  final bool center;
  final Color? textColor;
  final bool boldText;
  const IconTextRow({
    super.key, required this.icon, required this.text, this.center =false, this.textColor, this.boldText = false
  });

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: center? MainAxisAlignment.center: MainAxisAlignment.start,
        children: [
      icon,
      const SizedBox(width: 6),
      Text(text, style: TextStyle(color: textColor, fontWeight: boldText? FontWeight.bold: null ))
    ]);
  }
}