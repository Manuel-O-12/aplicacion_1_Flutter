import 'package:flutter/widgets.dart';

class Button extends StatelessWidget{

  final String text;
  final voidCallback? onPressed;
  final Color? bgcolor;
  final Color? textcolor;

  const Button({
    super.key,
    required this.text,
    this.onPressed,
    this.bgcolor = const Color(0xFF3333ff),
    this.textcolor = const Color(0xffffffff),
  });

  @override
  Widget build(BuildContext context) {
    
    return GestureDetector(
      onTap: onPressed,
      child:  Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: bgcolor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: const Color(0xff000000),
              offset: const Offset(0, 4),
              blurRadius: 6,
            )
          ]
        ),
        ),
        child: Text(text, 
        style: TextStyle(
          color: textcolor,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),)
      ),
  }

}