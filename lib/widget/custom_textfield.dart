import 'package:flutter/material.dart';

import 'help_widget.dart';

import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final IconData? prefixIcon;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final int maxLength;
  final ValueChanged<String>? onChanged;
  final Widget? suffixIcon;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.maxLength = 50,
    this.onChanged,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLength: maxLength,
      onChanged: onChanged,
      decoration: InputDecoration(
        counterText: "",
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey.shade500,
          fontSize: 14,
        ),
        suffix: suffixIcon,
        prefixIcon: prefixIcon != null
            ? Icon(
          prefixIcon,
          color: Colors.grey.shade600,
        )
            : null,
        filled: true,
        fillColor: Colors.grey.shade200,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 18,
          horizontal: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Colors.green,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}
Widget customDropdown({
  required String? value,
  required String label,
  required List<String> items,
  required ValueChanged<String?> onChanged,
  String hintText = "Select Option",
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

      /// 🔹 Label
      Text(
        label,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Color(0xFF1E2A5A),
        ),
      ),

      spaceHeight(8),

      /// 🔹 Dropdown Container
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: Colors.grey.shade300,
            width: 1,
          ),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isExpanded: true,
            value: items.contains(value) ? value : null,
            hint: Text(
              hintText,
              style: TextStyle(
                color: Colors.grey.shade400,
                fontSize: 14,
              ),
            ),
            icon: const Icon(
              Icons.keyboard_arrow_down,
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(14),
            dropdownColor: Colors.white,
            style: const TextStyle(
              color: Color(0xFF1E2A5A),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            items: items
                .map(
                  (item) => DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              ),
            )
                .toList(),
            onChanged: onChanged,
          ),
        ),
      ),
    ],
  );
}

