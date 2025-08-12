import 'package:flutter/material.dart';
import 'package:tesmeat_app/constant/app_colors.dart';

class BlueElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const BlueElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(312, 54),
        backgroundColor:primary_color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        textAlign: TextAlign.right,
        text,
        style: const TextStyle(
          
          fontSize: 20,
          color: Colors.white,
        ),
      ),
    );
  }
}



class WhiteElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const WhiteElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(300, 47),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.white,
        ),
      ),
    );
  }
}


class CustomTextFormField extends StatelessWidget {
  //final String hintText;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final TextInputType keyboardType;
  final bool obscureText;

  const CustomTextFormField({
    super.key,
   // required this.hintText,
    required this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 47,
      child: TextFormField(
        textDirection: TextDirection.rtl,
        controller: controller,
        validator: validator,
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
          filled: false, 
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(color: sixth_color, width: 1.5),
          ),
        ),
      ),
    );
  }
}
