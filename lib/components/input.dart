import 'package:flutter/widgets.dart';

class Input extends StatelessWidget {
  final String text;
  final String placeholder;
  final Color bgColor;
  final Color color;
  final TextEditingController controller;
  final bool isPassword;
  final TextInputType keyboardType;
  final String label;

  const Input ({
    super.key,
    required this.text,
    required this.label,
    required this.controller,
    this.color = const Color(0xffff0000),
    this.bgColor = const Color.fromARGB(255, 64, 125, 231)
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
  });

  @override
    Widget build(BuildContext context) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: const EdgeInsets.only(left: 4, bottom: 4),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: color
            ),
          ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.symmetric(horizontal: 4,vertical: 4),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Color(0x00000000),
                  offset: const Offset(0, 2),
                  blurRadius: 4,
                )
              ]
            ),

            child: EditableText(controller: controller, 
            focusNode: FocusNode(), 
            style: const TextStyle(
              fontSize: 16,
              color: Color(0x00000000)
            ), 
            cursorColor: Color(0x00000000) , 
            backgroundCursorColor: backgroundCursorColor),

          )
        ],
      )
    }

}