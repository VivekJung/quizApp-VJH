import 'package:flutter/material.dart';

circularLoading(double height) {
  return Container(
    height: height,
    color: Colors.transparent,
    child: const Center(
        child: CircularProgressIndicator(
      color: Colors.white,
    )),
  );
}
