import 'package:flutter/widgets.dart';

class IconTextRow extends StatelessWidget {
  final Icon icon;
  final String text;
  const IconTextRow({
    super.key, required this.icon, required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      icon,
      Text(text)
    ]);
  }
}