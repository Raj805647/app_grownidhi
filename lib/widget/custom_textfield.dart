import 'package:flutter/material.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

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
  int maxLines = 1,
  ValueChanged<String>? onChanged,
  VoidCallback? onTap,
  Widget? suffixIcon,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(hintText, style: TextStyle(color: Colors.white, fontSize: 14)),
      spaceHeight(8),
      TextField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        maxLength: maxLength,
        onChanged: onChanged,
        readOnly: isRead,
        onTap: onTap,
        maxLines: maxLines,
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
          contentPadding: const EdgeInsets.symmetric(
            vertical: 18,
            horizontal: 16,
          ),
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
      ),
    ],
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
          color: Colors.white,
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

Widget customMultiSelectDropdown({
  required String title,
  required List<String> items,
  required List<String> selectedItems,
  required Function(List<String>) onConfirm,
  IconData? prefixIcon,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.white,
        ),
      ),

      spaceHeight(8),
      MultiSelectDialogField<String>(

        items: items
            .map((item) => MultiSelectItem<String>(item, item))
            .toList(),

        initialValue: selectedItems,

        title: Text(title),


        searchable: true,

        buttonText: Text(title),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
        ),

        buttonIcon: Icon(prefixIcon ?? Icons.arrow_drop_down),

        selectedColor: Colors.blue,

        onConfirm: (values) {
          onConfirm(values);
        },

        chipDisplay: MultiSelectChipDisplay(
          chipColor: Colors.blue.shade100,
          textStyle: const TextStyle(color: Colors.black),
        ),
      ),
    ],
  );
}

Widget customRadioGroup({
  required String title,
  required List<dynamic> options,
  required String groupValue,
  required Function(dynamic) onChanged,
}) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.08),
      borderRadius: BorderRadius.circular(18),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 16,
          ),
        ),

        const SizedBox(height: 10),

        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: List.generate(
            options.length,
                (i) {
              final option = options[i];

              final isSelected = groupValue == option;

              return GestureDetector(
                onTap: () => onChanged(option),

                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Colors.white
                        : Colors.white.withOpacity(0.08),

                    borderRadius: BorderRadius.circular(14),

                    border: Border.all(
                      color: isSelected
                          ? Colors.white
                          : Colors.white.withOpacity(0.3),
                    ),
                  ),

                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected
                                ? Colors.deepPurple
                                : Colors.white,
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: Container(
                            width: isSelected ? 10 : 0,
                            height: isSelected ? 10 : 0,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.deepPurple,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 10),

                      Text(
                        option.toString(),
                        style: TextStyle(
                          color: isSelected
                              ? Colors.deepPurple
                              : Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    ),
  );
}

Widget customCheckboxGroup({
  required String title,
  required List<dynamic> options,
  required Function(dynamic) onTap,
  required bool Function(dynamic) isChecked,
}) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.08),
      borderRadius: BorderRadius.circular(18),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 16,
          ),
        ),

        const SizedBox(height: 10),

        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: List.generate(
            options.length,
                (i) {
              final option = options[i];

              final checked = isChecked(option);

              return GestureDetector(
                onTap: () => onTap(option),

                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: checked
                        ? Colors.white
                        : Colors.white.withOpacity(0.08),

                    borderRadius: BorderRadius.circular(14),

                    border: Border.all(
                      color: checked
                          ? Colors.white
                          : Colors.white.withOpacity(0.3),
                    ),
                  ),

                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: checked
                                ? Colors.deepPurple
                                : Colors.white,
                            width: 2,
                          ),
                          color: checked
                              ? Colors.deepPurple
                              : Colors.transparent,
                        ),
                        child: checked
                            ? const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 16,
                        )
                            : null,
                      ),

                      const SizedBox(width: 10),

                      Text(
                        option.toString(),
                        style: TextStyle(
                          color: checked
                              ? Colors.deepPurple
                              : Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    ),
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
