import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mock_interview_task/models/product_model.dart';

part 'cart_change_notifier.dart';

final cartChangeNotifierProvider = ChangeNotifierProvider<CartChangeNotifier>(
  (ref) => CartChangeNotifier(),
);