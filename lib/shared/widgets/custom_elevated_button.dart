import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final Function()? btnFunction;
  final String? label;
  final IconData icon;
  final Color? bgColor;
  const CustomElevatedButton({
    Key? key,
    this.btnFunction,
    this.label,
    required this.icon,
    this.bgColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: ElevatedButton.icon(
        onPressed: btnFunction ?? () {},
        icon: Icon(
          icon,
          color: Colors.white,
          size: 20,
        ),
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(24),
          backgroundColor: bgColor ?? Colors.transparent,
        ),
        label: Text(label ?? ""),
      ),
    );
  }
}
