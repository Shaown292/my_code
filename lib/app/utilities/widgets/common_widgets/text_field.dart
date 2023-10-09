import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final Color? fillColor;
  final String? hintText;
  final bool focusBorderActive;
  final bool enableBorderActive;
  final bool obsCureText;
  final Widget? suffixIcon;
  final Function()? iconOnTap;

  const CustomTextFormField({
    super.key,
    this.fillColor,
    this.hintText,
    this.focusBorderActive = false,
    this.enableBorderActive = false,
    this.suffixIcon,
    this.iconOnTap,
    this.obsCureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obsCureText,
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor ?? const Color(0xFFFDFBFF),
        hintText: hintText ?? 'Enter text',
        suffixIcon:
            InkWell(
              onTap: iconOnTap,
                child: suffixIcon ?? const SizedBox()),
        focusedBorder: focusBorderActive
            ? OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xFFEBDAF9)),
                borderRadius: BorderRadius.circular(8.0),
              )
            : null,
        enabledBorder: enableBorderActive
            ? OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xFFEBDAF9)),
                borderRadius: BorderRadius.circular(8.0),
              )
            : null,
      ),
    );
  }
}

// class CustomTextFormField extends StatelessWidget {
//   const CustomTextFormField({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       decoration: InputDecoration(
//         filled: true,
//         fillColor: Color(0xFFF4EBFC), // Light pink background color
//         hintText: 'Enter text',
//         suffixIcon: Icon(Icons.email), // Suffix icon
//         border: OutlineInputBorder(
//           borderSide: BorderSide.none,
//           borderRadius: BorderRadius.circular(10.0), // Optional: Add rounded corners
//         ),
//       ),
//     );
//   }
// }
