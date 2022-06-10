import 'dart:developer';

import 'package:flutter/cupertino.dart';

errorNotification() {
  return const Center(
    child: Text(
      'Oops! Looks like some error has occured',
    ),
  );
}

bool stat(isLoading) {
  bool loadStatus = isLoading;
  log('status: $loadStatus');
  return loadStatus;
}
