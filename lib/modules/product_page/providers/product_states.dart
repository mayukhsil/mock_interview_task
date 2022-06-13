import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mock_interview_task/models/product_model.dart';

part 'product_states.freezed.dart';

///Extension Method for easy comparison
extension ProductGetters on ProductState {
  bool get isLoading => this is _ProductStateLoading;
}

@freezed
abstract class ProductState with _$ProductState {
  ///Initial
  const factory ProductState.initial() = _ProductStateInitial;

  ///Loading
  const factory ProductState.loading() = _ProductStateLoading;

  ///Data
  const factory ProductState.data({required ProductModel product}) = _ProductStateData;

  ///Error
  const factory ProductState.error([String? error]) = _ProductStateError;
}