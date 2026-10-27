import 'package:flutter/material.dart';
import 'package:minbus_weather_app/Utils/Appcolors.dart';

class Mytextfieldcomponent extends StatefulWidget {
  final String? label;
  final String hintText;
  final TextEditingController controller;
  final bool isPassword;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextInputType keyboardType;
  // Added dynamic validator parameter
  final FormFieldValidator<String>? validator;

  const Mytextfieldcomponent({
    super.key,
    required this.hintText,
    required this.controller,
    this.label,
    this.isPassword = false,
    this.suffixIcon,
    this.prefixIcon,
    this.keyboardType = TextInputType.text,
    this.validator, // Initialized here
  });

  @override
  State<Mytextfieldcomponent> createState() => _MytextfieldcomponentState();
}

class _MytextfieldcomponentState extends State<Mytextfieldcomponent> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Appcolors.Textgreycolor,
            ),
          ),
          const SizedBox(height: 8),
        ],
        const SizedBox(height: 8),
        TextFormField(
          controller: widget.controller,
          obscureText: _obscureText,
          keyboardType: widget.keyboardType,

          // Uses the dynamic validator passed from outside,
          // or falls back to a default "cannot be empty" check if none is provided.
          validator: widget.validator ?? (value) {
            if (value == null || value.isEmpty) {
              return "This field cannot be empty";
            }
            return null;
          },

          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.isPassword
                ? IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            )
                : widget.suffixIcon,
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFF017A54),
                width: 1.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}
