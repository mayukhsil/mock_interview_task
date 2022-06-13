import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mock_interview_task/models/product_model.dart';
import 'package:mock_interview_task/modules/product_page/providers/product_states.dart';
import 'package:mock_interview_task/repositories/product_repository.dart';

part 'product_state_notifier.dart';

//Dependency Injection
final productStateNotifierProvider = StateNotifierProvider<ProductNotifier, ProductState>(
      (ref) => ProductNotifier(
    productRepository: ref.watch(_productRepositoryProvider),
  ),
);

//Repository Provider
final _productRepositoryProvider = Provider<IProductRepository>(
      (ref) => ProductRepository(),
);