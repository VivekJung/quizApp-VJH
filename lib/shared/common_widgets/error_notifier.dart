import 'dart:developer';

import 'package:flutter/cupertino.dart';

errorMessage(String? errorMessage) {
  errorMessage == ""
      ? errorMessage = "Oops! Looks like some error has occured"
      : errorMessage = errorMessage;
  return Center(child: Text(errorMessage!));
}

bool stat(isLoading) {
  bool loadStatus = isLoading;
  log('status: $loadStatus');
  return loadStatus;
}
