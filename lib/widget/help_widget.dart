import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

SizedBox spaceHeight(double height) {
  return SizedBox(height: height);
}

SizedBox spaceWidth(double width) {
  return SizedBox(width: width);
}

LinearGradient customGradientDesign(){
  return const LinearGradient(
    colors: [
      Color(0xff7F00FF),
      Color(0xffE100FF),
      Color(0xff00C6FF),
    ],
  );
}

Widget buildOtpField({
  required TextEditingController controller,
  Function(String)? onCompleted,
}) {
  return Pinput(
    controller: controller,
    keyboardType: TextInputType.number,
    length: 6,

    defaultPinTheme: PinTheme(
      width: 50,
      height: 55,
      textStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
    ),

    focusedPinTheme: PinTheme(
      width: 50,
      height: 55,
      textStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green, width: 2),
      ),
    ),

    submittedPinTheme: PinTheme(
      width: 50,
      height: 55,
      textStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(12),
      ),
    ),

    separatorBuilder: (index) => const SizedBox(width: 8),

    showCursor: true,
    cursor: Container(
      width: 2,
      height: 20,
      color: Colors.green,
    ),

    onCompleted: onCompleted,
  );
}