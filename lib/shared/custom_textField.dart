import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({super.key, required this.hint, required this.isPassword, required this.controller});
final String hint;
final bool isPassword;
final TextEditingController controller;

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
      cursorColor: AppColors.primaryColor,
      cursorHeight: 20,
      validator: (v){
        if(v==null || v.isEmpty ){
          return 'fill the ${widget.hint}';
        }
        null;
      },
      obscureText: _obscureText,

      decoration: InputDecoration(
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
              borderSide: BorderSide(color: Colors.white)
          ),
          hintText: widget.hint,
          hintStyle: TextStyle(color: Colors.white),
          fillColor: Colors.transparent,
          filled: true
      ),
    );
  }
}
