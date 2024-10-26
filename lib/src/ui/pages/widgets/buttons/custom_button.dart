import 'package:flutter/material.dart';


class CustomButton extends StatelessWidget {
  final void Function() onPressed;
  final String text;
  final Color? color;
  final bool isCardButton;

  const CustomButton(this.text,{
    super.key,
    required this.onPressed,
    this.color,
    this.isCardButton= false
  });


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: isCardButton?6 : 14),
        backgroundColor: color?? Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        minimumSize: Size(MediaQuery.of(context).size.width, 20),
      ),
      child: Text(text, style: TextStyle(fontWeight: FontWeight.bold, fontSize: isCardButton? 14 : 18)),
    );
  }
}
