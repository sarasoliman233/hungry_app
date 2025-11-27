import 'package:flutter/cupertino.dart';

class CustomText extends StatelessWidget {

  const CustomText({
    super.key,
    required this.text,
     this.color,
     this.weight,
     this.fontSize, this.maxLine});


final String text;
final Color? color;
final int? maxLine;
final FontWeight? weight;
final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
     text,
      maxLines: maxLine ?? 2,
      overflow: TextOverflow.ellipsis,
      textScaler: TextScaler.linear(1.0),
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: weight,

      ),

    );
  }
}
