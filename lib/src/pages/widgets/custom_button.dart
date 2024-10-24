import 'package:flutter/material.dart';


class CustomButton extends StatelessWidget {
  final void Function() onPressed;
  final String text;
  final Color? color;

  const CustomButton(this.text,{
    super.key,
    required this.onPressed,
    this.color,
  });


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 14),
        backgroundColor: color?? Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        minimumSize: Size(MediaQuery.of(context).size.width * 0.8, 50),
      ),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    );
  }
}
