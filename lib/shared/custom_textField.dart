import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({super.key, required this.hint, required this.isPassword, required this.controller, this.style,});
final String hint;
final bool isPassword;
final TextEditingController controller;
final TextStyle? style;


  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText;
  @override
  void initState() {
    _obscureText=widget.isPassword;
    super.initState();
  }
  void _togglePassword(){
    setState(() {
      _obscureText= ! _obscureText;
    });
  }
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      cursorColor: Colors.white,
      cursorHeight: 20,
      style: widget.style,
      validator: (v){
        if(v==null || v.isEmpty ){
          return 'fill the ${widget.hint}';
        }
        null;
      },
      obscureText: _obscureText,

      decoration: InputDecoration(
        errorStyle: TextStyle(
          color: Colors.red,  // لون النص
          fontSize: 14,                // الحجم
          fontWeight: FontWeight.w500, // السمك
          fontStyle: FontStyle.normal, // ميلان
          height: 1.2,                 // المسافة بين الأسطر
        ),

        suffixIcon: widget.isPassword ? GestureDetector(
            onTap: _togglePassword,
            child: Icon(CupertinoIcons.eye,color: Colors.white,)) : null,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.white)
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.white)
          ),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.red)
          ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.red),
        ),

        hintText: widget.hint,
          hintStyle: TextStyle(color: Colors.white),
          fillColor: Colors.transparent,
          filled: true,
      ),
    );
  }
}
