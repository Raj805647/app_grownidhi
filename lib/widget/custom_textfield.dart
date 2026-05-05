import 'package:flutter/material.dart';

import 'help_widget.dart';

import 'package:flutter/material.dart';

Widget customTextField({
  required String hintText,
  IconData? prefixIcon,
  TextEditingController? controller,
  TextInputType keyboardType = TextInputType.text,
  bool obscureText = false,
  bool isRead = false,
  int maxLength = 50,
  ValueChanged<String>? onChanged,
  VoidCallback? onTap,
  Widget? suffixIcon,
}) {
  return TextField(
    controller: controller,
    keyboardType: keyboardType,
    obscureText: obscureText,
    maxLength: maxLength,
    onChanged: onChanged,
    readOnly: isRead,
    onTap: onTap,
    decoration: InputDecoration(
      counterText: "",
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 14),

      /// ✅ FIXED (important)
      suffixIcon: suffixIcon,

      prefixIcon: prefixIcon != null
          ? Icon(prefixIcon, color: Colors.grey.shade600)
          : null,

      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Colors.green, width: 1.5),
      ),
    ),
  );
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
          border: Border.all(color: Colors.grey.shade300, width: 1),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isExpanded: true,
            value: items.contains(value) ? value : null,
            hint: Text(
              hintText,
              style: TextStyle(color: Colors.grey.shade400, fontSize: 14),
            ),
            icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
            borderRadius: BorderRadius.circular(14),
            dropdownColor: Colors.white,
            style: const TextStyle(
              color: Color(0xFF1E2A5A),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            items: items
                .map(
                  (item) =>
                      DropdownMenuItem<String>(value: item, child: Text(item)),
                )
                .toList(),
            onChanged: onChanged,
          ),
        ),
      ),
    ],
  );
}

Future<void> pickDateTime(
  BuildContext context,
  TextEditingController controller, {
  bool includeTime = false,
}) async {
  // Pick Date
  final DateTime? date = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1950),
    lastDate: DateTime(2100),
  );

  if (date == null) return;

  DateTime finalDateTime = date;

  if (includeTime) {
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time == null) return;

    finalDateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
  }

  // Set value in controller (formatted)
  controller.text = includeTime
      ? "${finalDateTime.toLocal()}".split('.')[0]
      : "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
}
