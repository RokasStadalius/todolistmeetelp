import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoappmeetelp/providers/auth_serivce.provider.dart';

final refreshListener = Provider<ValueNotifier<String>>((ref) {
  final notifier = ValueNotifier<String>('uninitialized');
  ref.listen(authNotifier, (prev, next) {
    if (prev != next) {
      notifier
        ..value = next.toString()
        // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
        ..notifyListeners();
    }
  });

  return notifier;
});
