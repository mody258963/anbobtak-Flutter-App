part of 'order_cubit_cubit.dart';

@immutable
abstract class OrderCubitState {}

class OrderCubitInitial extends OrderCubitState {}

class LodingState extends OrderCubitState {}

class GetOrders extends OrderCubitState {
  final List<OrderData> order;
  GetOrders({required this.order});
}

class Fail extends OrderCubitState {
  final String message;

  Fail(this.message);
}
